import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/dto/last_known_revision_wrapper.dart';
import 'package:todo_app/core/data/dto/single_task_network_response_dto.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app/core/data/dto/task_list_dto.dart';

part 'network_constants.dart';

final _log = Logger('NetworkTaskDataSource');

class NetworkTaskDataSource {
  final Dio _dio;
  NetworkTaskDataSource()
      : _dio = Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            headers: {_auth_header: '$_bearer ${dotenv.env["TOKEN"]}'},
            validateStatus: (status) => true,
            ),
            );

  Future<LastKnownRevisionWrapper<List<TaskDto>>?> getAllTasks() async {
    try {
      final resp = await _dio.get<Map<String, Object?>>(_list_path);
      switch (resp.statusCode) {
        case 200:
          final respList = TaskListDto.fromJson(resp.data!);
          return LastKnownRevisionWrapper(
            lastKnownRevision: respList.revision ?? 0,
            value: respList.list,
          );
        default:
          return null;
      }
    } catch (e) {
      _log.severe(e);
      return null;
    }
  }

  Future<LastKnownRevisionWrapper<List<TaskDto>>?> updateAllTasks(
    LastKnownRevisionWrapper<List<TaskDto>> tasks,
  ) async {
    try {
      final resp = await _dio.patch<Map<String, Object?>>(
        _list_path,
        data: TaskListDto(list: tasks.value),
        options: _revisionHeaderOptions(tasks.lastKnownRevision),
      );
      switch (resp.statusCode) {
        case 200:
          final respList = TaskListDto.fromJson(resp.data!);
          return LastKnownRevisionWrapper(
            lastKnownRevision: respList.revision ?? 0,
            value: respList.list,
          );
        default:
          return null;
      }
    } catch (e) {
      _log.severe(e);
      return null;
    }
  }

  Future<LastKnownRevisionWrapper<TaskDto>?> getTaskById(String id) async {
    try {
      final resp = await _dio.get<Map<String, Object?>>('$_list_path/$id');
      if (resp.statusCode == 200 && resp.data != null) {
        final responseElement =
            SingleTaskNetworkResponseDto.fromJson(resp.data!);
        return LastKnownRevisionWrapper(
          lastKnownRevision: responseElement.revision ?? 0,
          value: responseElement.element,
        );
      }
    } catch (e) {
      _log.severe(e);
      return null;
    }
    return null;
  }

  Future<TaskDto?> createTask(LastKnownRevisionWrapper<TaskDto> task) async {
    try {
      final resp = await _dio.post<Map<String, Object?>>(_list_path,
          options: _revisionHeaderOptions(task.lastKnownRevision),
          data:
              SingleTaskNetworkResponseDto(status: 'ok', element: task.value));
      switch (resp.statusCode) {
        case 200:
          return SingleTaskNetworkResponseDto.fromJson(resp.data!).element;
        default:
          return null;
      }
    } catch (e) {
      _log.severe(e);
      return null;
    }
  }

  Future<TaskDto?> modifyTask(LastKnownRevisionWrapper<TaskDto> task) async {
    try {
      final resp = await _dio.put<Map<String, Object?>>(_list_path,
          options: _revisionHeaderOptions(task.lastKnownRevision),
          data:
              SingleTaskNetworkResponseDto(status: 'ok', element: task.value));
      switch (resp.statusCode) {
        case 200:
          return SingleTaskNetworkResponseDto.fromJson(resp.data!).element;
        default:
          return null;
      }
    } catch (e) {
      _log.severe(e);
      return null;
    }
  }

  Future<bool> deleteTask(LastKnownRevisionWrapper<TaskDto> task) async {
    try {
      final resp = await _dio
          .delete<Map<String, Object?>>('$_list_path/${task.value.id}');
      switch (resp.statusCode) {
        case 200:
          return true;
        default:
          return false;
      }
    } catch (e) {
      _log.severe(e);
      return false;
    }
  }

  Options _revisionHeaderOptions(int lastKnownRevision) => Options(
        headers: {_lastKnownRevisionHeader: lastKnownRevision},
      );
}
