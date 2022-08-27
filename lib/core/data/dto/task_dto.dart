import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/core/data/dto/converters/timestamp_converter.dart';
import 'package:todo_app/core/data/dto/converters/nullable_timestamp_converter.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
class TaskDto with _$TaskDto {
  const TaskDto._();
  @HiveType(typeId: 0, adapterName: 'TaskDtoAdapter')
  @Assert('color == null || color.startsWith("#"), "Invalid color string"')
  factory TaskDto({
    @HiveField(0)
        required String id,
    @HiveField(1)
        required String text,
    @HiveField(2)
        required Importance importance,
    @HiveField(3)
    @NullableTimestampConverter()
        DateTime? deadline,
    @HiveField(4)
        required bool done,
    @HiveField(5)
    @Default('#ffffffff')
        String? color,
    @HiveField(6)
    @TimestampConverter()
    // Issue на эту тему открыт
    // https://github.com/rrousselGit/freezed/issues/488
    // ignore: invalid_annotation_target
    @JsonKey(name: 'created_at')
        required DateTime createdAt,
    @HiveField(7)
    @TimestampConverter()
    // ignore: invalid_annotation_target
    @JsonKey(name: 'changed_at')
        required DateTime changedAt,
    @HiveField(8)
    @TimestampConverter()
    // ignore: invalid_annotation_target
    @JsonKey(name: 'last_updated_by')
        required String lastUpdatedBy,
  }) = _TaskDto;
  factory TaskDto.fromJson(
    Map<String, Object?> json,
  ) =>
      _$TaskDtoFromJson(json);
  static List<TaskDto> listFromJson(
    List<Map<String, Object?>> list,
  ) =>
      list.map(TaskDto.fromJson).toList();

  static TaskDto fromEntity({
    required TaskEntity entity,
    required DateTime createdAt,
    required DateTime changedAt,
    required String lastUpdatedBy,
    String? color,
  }) =>
      TaskDto(
        id: entity.id,
        text: entity.text,
        importance: entity.importance,
        done: entity.done,
        deadline: entity.deadline,
        createdAt: createdAt,
        changedAt: changedAt,
        lastUpdatedBy: lastUpdatedBy,
      );

  TaskDto updateFromEntity(TaskEntity entity) {
    return copyWith(
      id: entity.id,
      text: entity.text,
      importance: entity.importance,
      done: entity.done,
      deadline: entity.deadline,
    );
  }
}
