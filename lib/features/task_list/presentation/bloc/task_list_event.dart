part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class ReloadTaskListEvent extends TaskListEvent {}

class SwitchDoneTaskVisibilityEvent extends TaskListEvent {}

class ChangeTaskDoneEvent extends TaskListEvent {
  final TaskEntity task;
  final bool done;
  ChangeTaskDoneEvent({required this.task, required this.done});
}

class DeleteTaskEvent extends TaskListEvent {
  final TaskEntity task;
  DeleteTaskEvent(this.task);
}

class CreateTaskEvent extends TaskListEvent {
  final String text;
  CreateTaskEvent(this.text);
}
