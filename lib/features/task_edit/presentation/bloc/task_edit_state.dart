import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';

part 'task_edit_state.freezed.dart';

@Freezed(equal: true)
class TaskEditState with _$TaskEditState {
  factory TaskEditState({
    required String? taskId,
    required bool loaded,
    required bool notFound,
    required bool modified,
    TaskEntity? task,
  }) = _TaskEditState;
}
