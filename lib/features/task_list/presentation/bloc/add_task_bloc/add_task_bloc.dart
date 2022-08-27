import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_bloc.dart';
import 'add_task_state.dart';

part 'add_task_event.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TaskListBloc taskListBloc;
  AddTaskBloc(this.taskListBloc) : super(AddTaskState(text: '')) {
    on<ChangeTextEvent>(onChangeText);
    on<SubmitTextEvent>(onSubmitText);
    on<UnfocusTextEvent>(onUnfocusText);
  }

  void createTask(String taskText) {
    this.taskListBloc.add(CreateTaskEvent(taskText));
  }

  Future<void> onChangeText(
    ChangeTextEvent event,
    Emitter<AddTaskState> emit,
  ) async {
    emit(state.copyWith(
      text: event.newText,
    ));
  }

  Future<void> onSubmitText(
    SubmitTextEvent event,
    Emitter<AddTaskState> emit,
  ) async {
    createTask(event.submittedText);
    emit(state.copyWith(text: ''));
  }

  Future<void> onUnfocusText(
      UnfocusTextEvent event, Emitter<AddTaskState> emit) async {
    createTask(state.text);
    emit(state.copyWith(text: ''));
  }
}
