import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/dto/last_known_revision_wrapper.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final _log = Logger('NetworkTaskDataSource');

class NetworkTaskDataSource {
  final Dio _dio;
  static const String _lastKnownRevisionHeader = 'X-Last-Known-Revision';
  static const String _baseUrl = 'https://beta.mrdekk.ru/todobackend';
  NetworkTaskDataSource()
      : _dio = Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            headers: {'Authorization': 'Bearer ${dotenv.env["TOKEN"]}'},
            validateStatus: (status) => true,
          ),
        );

  Future<LastKnownRevisionWrapper<List<TaskDto>>?> getAllTasks() async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>('/list');
      switch (resp.statusCode) {
        case 200:
          final respMap = resp.data as Map<String, dynamic>;
          return LastKnownRevisionWrapper(
            lastKnownRevision: respMap['revision'] as int,
            value: TaskDto.listFromJson(
              (respMap['list'] as List).cast<Map<String, dynamic>>(),
            ),
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
      final resp = await _dio.patch<Map<String, dynamic>>(
        '/list',
        data: {
          'status': 'ok',
          'list': tasks.value,
        },
        options: _revisionHeaderOptions(tasks.lastKnownRevision),
      );
      switch (resp.statusCode) {
        case 200:
          final respMap = resp.data as Map<String, dynamic>;
          return LastKnownRevisionWrapper(
            lastKnownRevision: respMap['revision'] as int,
            value: TaskDto.listFromJson(
              (respMap['list'] as List).cast<Map<String, dynamic>>(),
            ),
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
      final resp = await _dio.get<Map<String, dynamic>>('/list/$id');
      if (resp.statusCode == 200 && resp.data != null) {
        return LastKnownRevisionWrapper(
          lastKnownRevision: resp.data!['revision'] as int,
          value:
              TaskDto.fromJson(resp.data!['element'] as Map<String, dynamic>),
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
      final resp = await _dio.post<Map<String, dynamic>>(
        '/list',
        options: _revisionHeaderOptions(task.lastKnownRevision),
        data: task.value,
      );
      switch (resp.statusCode) {
        case 200:
          return TaskDto.fromJson(resp.data as Map<String, dynamic>);
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
      final resp = await _dio.put<Map<String, dynamic>>(
        '/list/${task.value.id}',
        options: _revisionHeaderOptions(task.lastKnownRevision),
        data: task.value,
      );
      switch (resp.statusCode) {
        case 200:
          return TaskDto.fromJson(resp.data as Map<String, dynamic>);
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
      final resp = await _dio.delete<Map<String, dynamic>>(
          '/list/${task.value.id}',
          options: _revisionHeaderOptions(task.lastKnownRevision));
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
