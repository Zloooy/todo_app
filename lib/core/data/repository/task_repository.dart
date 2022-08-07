import 'dart:async';

import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/local_data_source.dart';
import 'package:todo_app/core/data/data_source/network_task_data_source.dart';
import 'package:todo_app/core/data/dto/last_known_revision_wrapper.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';

final Logger _log = Logger('TaskRepository');

class TaskRepository {
  TaskRepository(
      {required NetworkTaskDataSource networkTaskDataSource,
      required LocalTaskDataSource localTaskDataSource})
      : _networkDS = networkTaskDataSource,
        _localDS = localTaskDataSource;

  final LocalTaskDataSource _localDS;
  final NetworkTaskDataSource _networkDS;

  Future<List<TaskEntity>> getAllTasks() async => (_localDS.getAllTasks()
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

  Future<bool> updateTasks() {
    if (unsyncedTasks.isNotEmpty) {
      return _tryPushTasksToServer();
    } else {
      return _tryPullTasksFromServer();
    }
  }

  Future<bool> addTask(TaskEntity taskEntity) async {
    try {
      await updateTasks();
      final DateTime creationTime = DateTime.now();
      final taskDto = TaskDto.fromEntity(
        entity: taskEntity,
        createdAt: creationTime, changedAt: creationTime,
        lastUpdatedBy: '0', // TODO Разобраться с форматом
      );
      final networkTaskDto = await _networkDS.createTask(
        LastKnownRevisionWrapper(
          value: taskDto,
          lastKnownRevision: _localDS.lastKnownRevision + 1,
        ),
      );
      await _localDS.addOrUpdateTask(networkTaskDto ?? taskDto);
      if (networkTaskDto != null) {
        await _localDS.setLastKnownRevision(_localDS.lastKnownRevision + 1);
        await _localDS.setLastSyncTime(networkTaskDto.createdAt);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> modifyTask(TaskEntity task) async {
    await updateTasks();
    final prevTask = await _localDS.findTaskById(task.id);
    if (prevTask == null) {
      // TODO Кинуть ошибку, такого быть не должно
      _log.severe('Trying to update non-existent task');
      return false;
    } else {
      final newTask = prevTask.updateFromEntity(task);
      final DateTime syncTime = DateTime.now();
      // TODO разобраться с 301 ошибкой
      final result = await _networkDS.modifyTask(
        LastKnownRevisionWrapper(
          lastKnownRevision: _localDS.lastKnownRevision + 1,
          value: newTask,
        ),
      );
      if (result != null) {
        await _localDS.setLastKnownRevision(_localDS.lastKnownRevision + 1);
        await _localDS.setLastSyncTime(syncTime);
      }
      await _localDS.addOrUpdateTask(result ?? newTask);
      return true;
    }
  }

  Future<bool> deleteTask(String id) async {
    await this.updateTasks();
    final taskToDelete = await this._localDS.findTaskById(id);
    if (taskToDelete != null) {
      final DateTime deleteTime = DateTime.now();
      final result = await _networkDS.deleteTask(
        LastKnownRevisionWrapper(
          lastKnownRevision: _localDS.lastKnownRevision + 1,
          value: taskToDelete,
        ),
      );
      if (result) {
        await _localDS.setLastKnownRevision(_localDS.lastKnownRevision + 1);
        await _localDS.setLastSyncTime(deleteTime);
      }
      await _localDS.deleteTask(id);
      return true;
    }
    return false;
    // TODO добавить запись удалённых локально, но не синхронизированных
    // задач с попыткой из затирания в updateTasks
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

  Future<bool> _tryPushTasksToServer() async {
    List<TaskDto> unsyncedTasks = this.unsyncedTasks;
    if (unsyncedTasks.isNotEmpty) {
      DateTime operationTime = DateTime.now();
      final result = await _networkDS.updateAllTasks(
        LastKnownRevisionWrapper(
          value: _localDS.getAllTasks(),
          lastKnownRevision: _localDS.lastKnownRevision + 1,
        ),
      );
      if (result != null) {
        await _localDS.setLastSyncTime(operationTime);
        await _localDS.setLastKnownRevision(result.lastKnownRevision);
        await _localDS.updateAllTasks(result.value);
        return true;
      }
      // TODO добавить возвращение ошибок ревизии из NetworkDataSource и
      // их разрешение - получение последней ревизии с сервера и её слияние с текущей.
      // Решить, что делать с дублями.
      return false;
    }
    return true;
  }

  Future<bool> _tryPullTasksFromServer() async {
    final response = await _networkDS.getAllTasks();
    if (response != null) {
      if (response.lastKnownRevision < _localDS.lastKnownRevision) {
        // TODO кинуть ошибку, такого быть не должно
        _log.severe('Response revision smaller than local');
        return true;
      } else {
        if (response.lastKnownRevision > _localDS.lastKnownRevision) {
          DateTime requestTime = DateTime.now();
          List<TaskDto> unsyncedTasks = this.unsyncedTasks;
          if (unsyncedTasks.isEmpty) {
            _localDS.updateAllTasks(response.value);
            _localDS.setLastKnownRevision(response.lastKnownRevision);
            _localDS.setLastSyncTime(requestTime);
            return true;
          } else {
            // TODO Добавить слияние
          }
        }
      }
    }
    return false;
  }

  static const List<String> _texts = [
    "Купить что-то",
    "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обрезается"
  ];
  T exp<T>(T el) => el;

  Future<List<TaskEntity>> _getAllTasksTEST() async {
    //await Future.delayed<void>(const Duration(seconds: 5));
    return TaskRepository._texts
        .map(
          (String text) => Importance.values
              .map(
                (Importance importance) => const [true, false].map(
                  (bool done) => TaskEntity(
                    id: '111',
                    text: text,
                    importance: importance,
                    done: done,
                  ),
                ),
              )
              .expand(exp),
        )
        .expand(exp)
        .cast<TaskEntity>()
        .toList();
  }
}
