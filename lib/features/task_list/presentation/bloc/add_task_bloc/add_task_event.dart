part of 'add_task_bloc.dart';

@immutable
abstract class AddTaskEvent {
  const AddTaskEvent();
}

class ChangeTextEvent extends AddTaskEvent {
  final String newText;
  const ChangeTextEvent({required this.newText});
}

class SubmitTextEvent extends AddTaskEvent {
  final String submittedText;
  const SubmitTextEvent({required this.submittedText});
}
