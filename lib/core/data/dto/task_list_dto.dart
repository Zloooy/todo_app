import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/core/data/dto/task_dto.dart';

part 'task_list_dto.freezed.dart';
part 'task_list_dto.g.dart';

@freezed
class TaskListDto with _$TaskListDto {
  factory TaskListDto({
    @Default('ok') String status,
    int? revision,
    required List<TaskDto> list,
  }) = _TaskListDto;

  factory TaskListDto.fromJson(Map<String, Object?> json) =>
      _$TaskListDtoFromJson(json);
}
