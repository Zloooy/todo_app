import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';

part 'task_list_state.freezed.dart';

@freezed
class TaskListState with _$TaskListState {
  factory TaskListState({
    required List<TaskEntity> tasks,
    required bool loaded,
    required bool showDone,
    @Default(0) int doneCount,
  }) = _TaskListState;
}
