part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {
  const TaskListEvent();
}

class ReloadTaskListEvent extends TaskListEvent {}

class SwitchDoneTaskVisibilityEvent extends TaskListEvent {}

class ChangeTaskDoneEvent extends TaskListEvent {
  final TaskEntity task;
  final bool done;
  const ChangeTaskDoneEvent({required this.task, required this.done});
}

class DeleteTaskEvent extends TaskListEvent {
  final TaskEntity task;
  const DeleteTaskEvent(this.task);
}

class CreateTaskEvent extends TaskListEvent {
  final String text;
  const CreateTaskEvent(this.text);
}
