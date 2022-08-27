import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/data/enum/network_state.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_state.dart';
part 'task_list_event.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc(this._repository)
      : super(TaskListState(
            tasks: const [],
            loaded: false,
            showDone: true,
            showNotification: false)) {
    on<ReloadTaskListEvent>(onReloadTasks);
    on<SwitchDoneTaskVisibilityEvent>(onSwitchDoneTaskVisibility);
    on<ChangeTaskDoneEvent>(onChangeTaskDone);
    on<DeleteTaskEvent>(onDeleteTask);
    on<CreateTaskEvent>(onCreateTaskEvent);
    add(ReloadTaskListEvent());
  }
  final TaskRepository _repository;
  Future<void> onReloadTasks(
    TaskListEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(loaded: false));
    final result = await _repository.updateTasks();
    List<TaskEntity> tasks = (await _repository.getAllTasks());
    int doneCount = tasks.where((task) => task.done).length;
    emit(
      state.copyWith(
        tasks:
            tasks.where((element) => state.showDone || !element.done).toList(),
        doneCount: doneCount,
        loaded: true,
        operationResult: result,
        showNotification: result != NetworkState.SUCCESS,
      ),
    );
  }

  Future<void> onSwitchDoneTaskVisibility(
    TaskListEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(
      loaded: false,
      showDone: !state.showDone,
    ));
    add(ReloadTaskListEvent());
  }

  Future<void> onChangeTaskDone(
    ChangeTaskDoneEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(loaded: false));
    final result = await _repository.modifyTask(event.task.copyWith(
      done: event.done,
    ));
    emit(state.copyWith(
        operationResult: result,
        showNotification: result != NetworkState.SUCCESS));
    add(ReloadTaskListEvent());
  }

  Future<void> onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(loaded: false));
    final result = await _repository.deleteTask(event.task.id);
    emit(state.copyWith(
        operationResult: result,
        showNotification: result != NetworkState.SUCCESS));
    add(ReloadTaskListEvent());
  }

  Future<void> onCreateTaskEvent(
    CreateTaskEvent event,
    Emitter<TaskListState> emit,
  ) async {
    emit(state.copyWith(
      loaded: false,
    ));
    TaskEntity newTask = TaskEntity.blank().copyWith(text: event.text);
    final result = await _repository.addTask(newTask);
    emit(state.copyWith(
      operationResult: result,
      showNotification: result != NetworkState.SUCCESS,
    ));
    add(ReloadTaskListEvent());
  }
}
