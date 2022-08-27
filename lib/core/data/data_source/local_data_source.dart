import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';

import 'package:todo_app/core/data/enum/importance.dart';

final Logger _log = Logger('LocalDataSource');

class LocalTaskDataSource {
  factory LocalTaskDataSource() => _instance ??= LocalTaskDataSource._();

  LocalTaskDataSource._();

  static const String TASK_BOX_NAME = 'tasks';
  static const String INFO_BOX_NAME = 'revision';
  static const String LAST_KNOWN_REVISION_KEY = 'lastKnownRevision';
  static const String LAST_SYNC_TIME_KEY = 'lastSyncTime';
  static const String TASK_IDS_TO_DELETE_KEY = 'taskIdsToDelete';

  static LocalTaskDataSource? _instance;
  static late Box<TaskDto> taskBox;
  static late Box<dynamic> infoBox;
  static bool _inited = false;

  static Future<void> init() async {
    _log.info('Started initialization');
    if (!_inited) {
      _log.info('Not inited yet');
      await Hive.initFlutter();
      _log.info('Hive inited');
      Hive.registerAdapter(TaskDtoAdapter());
      Hive.registerAdapter(ImportanceAdapter());
      taskBox = await _safelyOpenHiveBox<TaskDto>(TASK_BOX_NAME);
      infoBox = await _safelyOpenHiveBox<dynamic>(INFO_BOX_NAME);
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
      infoBox.get(LAST_KNOWN_REVISION_KEY, defaultValue: -1) as int;

  Future<void> setLastKnownRevision(int value) =>
      infoBox.put(LAST_KNOWN_REVISION_KEY, value);

  DateTime get lastSyncTime => infoBox.get(LAST_SYNC_TIME_KEY,
      defaultValue: DateTime.fromMicrosecondsSinceEpoch(0)) as DateTime;

  Future<void> setLastSyncTime(DateTime value) =>
      infoBox.put(LAST_SYNC_TIME_KEY, value);

  Future<void> setTaskIdsToDelete(List<String> ids) =>
      infoBox.put(TASK_IDS_TO_DELETE_KEY, ids);

  List<String> get taskIdsToDelete =>
      infoBox.get(TASK_IDS_TO_DELETE_KEY, defaultValue: const <String>[])
          as List<String>;

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
