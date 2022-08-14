import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/adapter/color_adapter.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';

import 'package:todo_app/core/data/enum/importance.dart';

final Logger _log = Logger('LocalDataSource');

class LocalTaskDataSource {
  factory LocalTaskDataSource() => _instance ??= LocalTaskDataSource._();

  LocalTaskDataSource._();

  static LocalTaskDataSource? _instance;
  static late Box<TaskDto> taskBox;
  static late Box<dynamic> revisionBox;
  static bool _inited = false;

  static Future<void> init() async {
    _log.info('Started initialization');
    if (!_inited) {
      _log.info('Not inited yet');
      await Hive.initFlutter();
      _log.info('Hive inited');
      Hive.registerAdapter(TaskDtoAdapter());
      Hive.registerAdapter(ImportanceAdapter());
      Hive.registerAdapter(ColorAdapter());
      taskBox = await _safelyOpenHiveBox<TaskDto>('tasks');
      revisionBox = await _safelyOpenHiveBox<dynamic>('revision');
      _log.info('Hive boxes inited');
      _inited = true;
    }
  }

  static Future<Box<T>> _safelyOpenHiveBox<T>(String boxName) async {
    Box<T>? result;
    try {
      result = await Hive.openBox<T>(boxName);
    } catch (e) {
      _log.severe(e);
      await Hive.deleteBoxFromDisk(boxName);
      result = await Hive.openBox<T>(boxName);
    }
    return result;
  }

  Future<bool> addOrUpdateTask(TaskDto task) async {
    try {
      await taskBox.put(task.id, task);
      return true;
    } catch (e) {
      _log.severe(e);
      return false;
    }
  }

  List<TaskDto> getAllTasks() {
    return taskBox.values.toList();
  }

  Future<bool> updateAllTasks(List<TaskDto> tasks) async {
    try {
      await taskBox.clear();
      for (final TaskDto task in tasks) {
        await taskBox.put(task.id, task);
      }
      return true;
    } catch (e) {
      _log.severe(e);
      return false;
    }
  }

  Future<void> deleteTask(String id) {
    return taskBox.delete(id);
  }

  int get lastKnownRevision =>
      revisionBox.get("lastKnownRevision", defaultValue: -1) as int;
  Future<void> setLastKnownRevision(int value) =>
      revisionBox.put("lastKnownRevision", value);
  DateTime get lastSyncTime => revisionBox.get("lastSyncTime",
      defaultValue: DateTime.fromMicrosecondsSinceEpoch(0)) as DateTime;
  Future<void> setLastSyncTime(DateTime value) =>
      revisionBox.put("lastSyncTime", value);
  Future<TaskDto?> findTaskById(String id) async {
    try {
      return taskBox.get(id);
    } on StateError {
      _log.info('Failed to get $id');
      return null;
    } catch (e) {
      _log.warning('Unexpected error on finding task');
      return null;
    }
  }
}
