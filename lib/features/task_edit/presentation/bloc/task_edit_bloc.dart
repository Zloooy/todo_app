import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/data/enum/network_state.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';

import 'task_edit_state.dart';
part 'task_edit_event.dart';

// TODO добавить вывод уведомлений о сетевых ошибках
class TaskEditBloc extends Bloc<TaskEditEvent, TaskEditState> {
  final TaskRepository _repository;
  TaskEditBloc(
      {required String? taskId, required TaskRepository taskRepository})
      : _repository = taskRepository,
        super(TaskEditState(
            taskId: taskId, loaded: false, modified: false, notFound: false)) {
    on<LoadTaskEvent>(onLoadTaskEvent);
    on<ModifyTaskEvent>(onModifyTaskEvent);
    on<SaveTaskEvent>(onSaveTaskEvent);
    on<DeleteTaskEvent>(onDeleteTaskEvent);
    add(LoadTaskEvent());
  }

  Future<void> onLoadTaskEvent(
      LoadTaskEvent event, Emitter<TaskEditState> emit) async {
    emit(state.copyWith(loaded: false));
    TaskEntity? task;
    bool modified = false;
    bool notFound = false;
    if (state.taskId != null) {
      task = await _repository.findTaskById(state.taskId!);
      modified = task == null;
      notFound = task == null;
    } else {
      task = TaskEntity.blank();
      modified = true;
    }
    emit(state.copyWith(
        task: task, loaded: true, modified: modified, notFound: notFound));
  }

  Future<void> onModifyTaskEvent(
      ModifyTaskEvent event, Emitter<TaskEditState> emit) async {
    emit(state.copyWith(task: event.newTask, modified: true));
  }

  Future<void> onSaveTaskEvent(
      SaveTaskEvent event, Emitter<TaskEditState> emit) async {
    if (state.task != null) {
      NetworkState saveResult;
      if (state.taskId == null) {
        saveResult = await _repository.addTask(state.task!);
      } else {
        saveResult = await _repository.modifyTask(state.task!);
      }
      if (saveResult == NetworkState.SUCCESS) {
        emit(state.copyWith(taskId: state.task!.id, modified: false));
      }
    }
  }

  Future<void> onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskEditState> emit) async {
    if (state.task != null && state.taskId != null) {
      await _repository.deleteTask(state.task!.id);
    }
    event.postDeleteCallback();
  }
}
