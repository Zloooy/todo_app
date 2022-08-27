import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/data_source/dio_transformer/ignore_body_format_transformer.dart';
import 'package:todo_app/core/data/dto/last_known_revision_wrapper.dart';
import 'package:todo_app/core/data/dto/network_state_wrapper.dart';
import 'package:todo_app/core/data/dto/single_task_network_response_dto.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app/core/data/dto/task_list_dto.dart';
import 'package:todo_app/core/data/enum/network_state.dart';

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
        )..transformer = IgnoreBodyFormatTransformer();

  Future<NetworkStateWrapper<LastKnownRevisionWrapper<List<TaskDto>>?>>
      getAllTasks() async {
    try {
      NetworkStateWrapper<Map<String, Object?>?> resp = await safeNetworkCall(
          () => _dio.get<Map<String, Object?>>(_list_path));
      switch (resp.state) {
        case NetworkState.SUCCESS:
          final respList = TaskListDto.fromJson(resp.value!);
          return NetworkStateWrapper(
              state: resp.state,
              value: LastKnownRevisionWrapper(
                lastKnownRevision: respList.revision ?? 0,
                value: respList.list,
              ));
        default:
          return resp.to();
      }
    } catch (e) {
      _log.severe(e);
      return NetworkStateWrapper(
          state: NetworkState.UNKNOWN_ERROR, value: null);
    }
  }

  Future<NetworkStateWrapper<LastKnownRevisionWrapper<List<TaskDto>>?>>
      updateAllTasks(
    LastKnownRevisionWrapper<List<TaskDto>> tasks,
  ) async {
    try {
      final resp = await safeNetworkCall(() => _dio.patch<Map<String, Object?>>(
            _list_path,
            data: TaskListDto(list: tasks.value),
            options: _revisionHeaderOptions(tasks.lastKnownRevision),
          ));
      switch (resp.state) {
        case NetworkState.SUCCESS:
          final respList = TaskListDto.fromJson(resp.value!);
          return NetworkStateWrapper(
            state: resp.state,
            value: LastKnownRevisionWrapper(
              lastKnownRevision: respList.revision ?? 0,
              value: respList.list,
            ),
          );
        case NetworkState.WRONG_REVISION:
          return NetworkStateWrapper(state: resp.state, value: null);
        default:
          return resp.to();
      }
    } catch (e) {
      _log.severe(e);
      return NetworkStateWrapper(
        state: NetworkState.UNKNOWN_ERROR,
        value: null,
      );
    }
  }

  Future<NetworkStateWrapper<LastKnownRevisionWrapper<TaskDto>?>> getTaskById(
      String id) async {
    try {
      final resp = await safeNetworkCall(
          () => _dio.get<Map<String, Object?>>('$_list_path/$id'));
      if (resp.state == NetworkState.SUCCESS) {
        final responseElement =
            SingleTaskNetworkResponseDto.fromJson(resp.value!);
        return NetworkStateWrapper(
          state: resp.state,
          value: LastKnownRevisionWrapper(
            lastKnownRevision: responseElement.revision ?? 0,
            value: responseElement.element,
          ),
        );
      }
      return resp.to();
    } catch (e) {
      _log.severe(e);
      return NetworkStateWrapper(
        state: NetworkState.UNKNOWN_ERROR,
        value: null,
      );
    }
  }

  Future<NetworkStateWrapper<TaskDto?>> createTask(
    LastKnownRevisionWrapper<TaskDto> task,
  ) async {
    try {
      final resp = await safeNetworkCall(() => _dio.post<Map<String, Object?>>(
            _list_path,
            options: _revisionHeaderOptions(task.lastKnownRevision),
            data: SingleTaskNetworkResponseDto(
              element: task.value,
            ),
          ));
      switch (resp.state) {
        case NetworkState.SUCCESS:
          return NetworkStateWrapper(
            state: resp.state,
            value: SingleTaskNetworkResponseDto.fromJson(resp.value!).element,
          );
        default:
          return resp.to();
      }
    } catch (e) {
      _log.severe(e);
      return NetworkStateWrapper(
        state: NetworkState.UNKNOWN_ERROR,
        value: null,
      );
    }
  }

  Future<NetworkStateWrapper<TaskDto?>> modifyTask(
      LastKnownRevisionWrapper<TaskDto> task) async {
    try {
      final resp = await safeNetworkCall(() => _dio.put<Map<String, Object?>>(
          '$_list_path/${task.value.id}',
          options: _revisionHeaderOptions(task.lastKnownRevision),
          data: SingleTaskNetworkResponseDto(element: task.value)));
      switch (resp.state) {
        case NetworkState.SUCCESS:
          return NetworkStateWrapper(
              state: resp.state,
              value:
                  SingleTaskNetworkResponseDto.fromJson(resp.value!).element);
        default:
          return resp.to();
      }
    } catch (e) {
      _log.severe(e);
      return NetworkStateWrapper(
        state: NetworkState.UNKNOWN_ERROR,
        value: null,
      );
    }
  }

  Future<NetworkState> deleteTask(
      LastKnownRevisionWrapper<TaskDto> task) async {
    try {
      final resp = await safeNetworkCall(
        () => _dio.delete<Map<String, Object?>>(
          '$_list_path/${task.value.id}',
          options: _revisionHeaderOptions(task.lastKnownRevision),
        ),
      );
      return resp.state;
    } catch (e) {
      _log.severe(e);
      return NetworkState.UNKNOWN_ERROR;
    }
  }

  Future<NetworkStateWrapper<T?>> safeNetworkCall<T>(
      Future<Response<T>> Function() func) async {
    try {
      final Response<T> response = await func();
      NetworkState state = _mapHttpStatusToNetworkState(response.statusCode!);
      return NetworkStateWrapper(
        state: state,
        value: state == NetworkState.SUCCESS ? response.data : null,
      );
    } on DioError catch (e) {
      late final NetworkState result;
      if (e.response != null) {
        result = _mapHttpStatusToNetworkState(e.response!.statusCode!);
      } else {
        result = NetworkState.NO_CONNECTION;
      }
      return NetworkStateWrapper(
        state: result,
        value: null,
      );
    }
  }

  NetworkState _mapHttpStatusToNetworkState(int status) {
    switch (status) {
      case 200:
        return NetworkState.SUCCESS;
      case 400:
        return NetworkState.WRONG_REVISION;
      case 401:
        return NetworkState.UNAUTHORIZED;
      case 404:
        return NetworkState.NOT_FOUND;
      case 522:
        return NetworkState.NO_CONNECTION;
      default:
        return NetworkState.UNKNOWN_ERROR;
    }
  }

  Options _revisionHeaderOptions(int lastKnownRevision) => Options(
        headers: {_lastKnownRevisionHeader: lastKnownRevision},
      );
}
