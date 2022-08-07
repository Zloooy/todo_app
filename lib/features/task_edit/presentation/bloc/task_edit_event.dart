part of 'task_edit_bloc.dart';

@immutable
abstract class TaskEditEvent {}

class LoadTaskEvent extends TaskEditEvent {}

class SaveTaskEvent extends TaskEditEvent {}

class ModifyTaskEvent extends TaskEditEvent {
  final TaskEntity newTask;
  ModifyTaskEvent(this.newTask);
}

class DeleteTaskEvent extends TaskEditEvent {
  final TaskEntity task;
  final void Function() postDeleteCallback;
  DeleteTaskEvent(this.task, this.postDeleteCallback);
}
