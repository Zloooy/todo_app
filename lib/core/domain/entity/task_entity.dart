import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';
import 'package:uuid/uuid.dart';
part 'task_entity.freezed.dart';

@Freezed(equal: true)
@immutable
class TaskEntity with _$TaskEntity {
  const factory TaskEntity(
      {required String id,
      required String text,
      required Importance importance,
      DateTime? deadline,
      required bool done}) = _TaskEntity;
  const TaskEntity._();
  static TaskEntity fromDto(TaskDto dto) => TaskEntity(
      id: dto.id,
      text: dto.text,
      importance: dto.importance,
      deadline: dto.deadline,
      done: dto.done);
  static TaskEntity blank() {
    return TaskEntity(
        id: Uuid().v4().toString(),
        text: "",
        importance: Importance.basic,
        done: false);
  }
}
