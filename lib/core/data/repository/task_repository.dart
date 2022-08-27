import 'dart:async';

import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/data/data_source/network_task_data_source.dart';
import 'package:todo_app/core/data/dto/last_known_revision_wrapper.dart';
import 'package:todo_app/core/data/dto/network_state_wrapper.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';
import 'package:todo_app/core/data/enum/network_state.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';

final Logger _log = Logger('TaskRepository');

class TaskRepository {
  TaskRepository({
    required NetworkTaskDataSource networkTaskDataSource,
    required LocalTaskDataSource localTaskDataSource,
  })  : _networkDS = networkTaskDataSource,
        _localDS = localTaskDataSource;

  final LocalTaskDataSource _localDS;
  final NetworkTaskDataSource _networkDS;

  Future<List<TaskEntity>> getAllTasks() async => (await _localDS.getAllTasks()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt)))
      .map(TaskEntity.fromDto)
      .cast<TaskEntity>()
      .toList();

  Future<TaskEntity?> findTaskById(String id) async {
    await updateTasks();
    final dto = await _localDS.findTaskById(id);
    if (dto != null) {
      return TaskEntity.fromDto(dto);
    }
    return null;
  }

  Future<NetworkState> addTask(TaskEntity taskEntity) async {
    try {
      await updateTasks();
      final DateTime creationTime = DateTime.now();
      final taskDto = TaskDto.fromEntity(
        entity: taskEntity,
        createdAt: creationTime, changedAt: creationTime,
        lastUpdatedBy: '0', // TODO Разобраться с форматом
      );
      final networkTaskResponse = await _networkDS.createTask(
        LastKnownRevisionWrapper(
          value: taskDto,
          lastKnownRevision: _localDS.lastKnownRevision,
        ),
      );
      final TaskDto taskToAdd =
          (networkTaskResponse.state == NetworkState.SUCCESS
                  ? networkTaskResponse.value
                  : null) ??
              taskDto;
      await _localDS.addOrUpdateTask(taskToAdd);
      if (networkTaskResponse.state == NetworkState.SUCCESS) {
        await _localDS.setLastKnownRevision(_localDS.lastKnownRevision + 1);
        await _localDS.setLastSyncTime(networkTaskResponse.value!.createdAt);
      }
      return networkTaskResponse.state;
    } catch (e) {
      return NetworkState.UNKNOWN_ERROR;
    }
  }

  Future<NetworkState> modifyTask(TaskEntity task) async {
    await updateTasks();
    final prevTask = await _localDS.findTaskById(task.id);
    if (prevTask == null) {
      // TODO Кинуть ошибку, такого быть не должно
      _log.severe('Trying to update non-existent task');
      return NetworkState.UNKNOWN_ERROR;
    } else {
      final newTask = prevTask.updateFromEntity(task);
      final DateTime syncTime = DateTime.now();
      // TODO разобраться с 301 ошибкой
      final result = await _networkDS.modifyTask(
        LastKnownRevisionWrapper(
          lastKnownRevision: _localDS.lastKnownRevision,
          value: newTask,
        ),
      );
      if (result.state == NetworkState.SUCCESS) {
        await _localDS.setLastKnownRevision(_localDS.lastKnownRevision + 1);
        await _localDS.setLastSyncTime(syncTime);
      }
      final TaskDto taskToAdd =
          (result.state == NetworkState.SUCCESS ? result.value : null) ??
              newTask;
      await _localDS.addOrUpdateTask(taskToAdd);
      return result.state;
    }
  }

  Future<NetworkState> deleteTask(String id) async {
    try {
      await updateTasks();
      final taskToDelete = await this._localDS.findTaskById(id);
      if (taskToDelete != null) {
        final DateTime deleteTime = DateTime.now();
        final result = (await _networkDS.deleteTask(LastKnownRevisionWrapper(
          lastKnownRevision: _localDS.lastKnownRevision,
          value: taskToDelete,
        )));
        if (result == NetworkState.SUCCESS) {
          await _localDS.setLastKnownRevision(_localDS.lastKnownRevision + 1);
          await _localDS.setLastSyncTime(deleteTime);
        } else if (result != NetworkState.NOT_FOUND) {
          await this
              ._localDS
              .setTaskIdsToDelete([...this._localDS.taskIdsToDelete, id]);
        }
        await _localDS.deleteTask(id);
        return result;
      }
      return NetworkState.NOT_FOUND;
    } catch (e) {
      _log.severe(e);
      return NetworkState.UNKNOWN_ERROR;
    }
  }

  List<TaskDto> get unsyncedTasks {
    DateTime lastSyncTime = _localDS.lastSyncTime;
    return _localDS
        .getAllTasks()
        .where(
          (TaskDto task) =>
              task.changedAt.millisecondsSinceEpoch >
              lastSyncTime.millisecondsSinceEpoch,
        )
        .toList();
  }

  List<String> get taskIdsToDelete => _localDS.taskIdsToDelete;

  bool get hasUnsyncedInfo =>
      unsyncedTasks.isNotEmpty || taskIdsToDelete.isNotEmpty;

  Future<NetworkState> updateTasks() async {
    try {
      if (!this.hasUnsyncedInfo) {
        DateTime operationTime = DateTime.now();
        final networkResponse = await _networkDS.getAllTasks();
        if (networkResponse.state == NetworkState.SUCCESS) {
          await _localDS.updateAllTasks(networkResponse.value!.value);
          await _localDS
              .setLastKnownRevision(networkResponse.value!.lastKnownRevision);
          await _localDS.setLastSyncTime(operationTime);
        }
        return networkResponse.state;
      } else {
        final taskListNetworkResponse = await _networkDS.getAllTasks();
        if (taskListNetworkResponse.state == NetworkState.SUCCESS) {
          final remoteRevision =
              taskListNetworkResponse.value!.lastKnownRevision;
          List<TaskDto> tasksToPush =
              (remoteRevision <= this._localDS.lastKnownRevision)
                  ? this._localDS.getAllTasks()
                  : _mergeRemoteTasks(
                      taskListNetworkResponse.value!.value,
                      this._localDS.getAllTasks(),
                      this._localDS.taskIdsToDelete,
                    );
          final DateTime operationTime = DateTime.now();
          final NetworkStateWrapper<LastKnownRevisionWrapper<List<TaskDto>>?>
              pushTasksNetworkResponse =
              await this._networkDS.updateAllTasks(LastKnownRevisionWrapper(
                    value: tasksToPush,
                    lastKnownRevision: remoteRevision,
                  ));
          if (pushTasksNetworkResponse.state == NetworkState.SUCCESS) {
            await this._localDS.setLastKnownRevision(
                pushTasksNetworkResponse.value!.lastKnownRevision);
            await this._localDS.setLastSyncTime(operationTime);
            await this
                ._localDS
                .updateAllTasks(pushTasksNetworkResponse.value!.value);
            await this._localDS.setTaskIdsToDelete([]);
          }
          return pushTasksNetworkResponse.state;
        }
        return taskListNetworkResponse.state;
      }
    } catch (e) {
      return NetworkState.UNKNOWN_ERROR;
    }
  }

  static List<TaskDto> _mergeRemoteTasks(
      List<TaskDto> remote, List<TaskDto> local, List<String> taskIdsToDelete) {
    remote = remote
        .where((element) => !taskIdsToDelete.contains(element.id))
        .toList();
    return [...local, ...remote].fold(<TaskDto>[],
        (List<TaskDto> previousValue, TaskDto currElement) {
      final TaskDto? otherElement = _firstWhereOrNull(
          previousValue, (element) => currElement.id == element.id);
      if (otherElement != null) {
        previousValue.removeWhere((element) => currElement.id == element.id);
        currElement = _pickNewest(currElement, otherElement);
      }
      return [...previousValue, currElement];
    });
  }

  static T? _firstWhereOrNull<T>(List<T> list, bool Function(T) checker) {
    try {
      return list.firstWhere(checker);
    } on StateError catch (e) {
      return null;
    }
  }

  static TaskDto _pickNewest(TaskDto first, TaskDto second) =>
      first.changedAt.microsecondsSinceEpoch >=
              second.changedAt.millisecondsSinceEpoch
          ? first
          : second;
}
