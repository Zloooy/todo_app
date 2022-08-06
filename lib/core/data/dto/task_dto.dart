import 'dart:ui' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

//extension  EntityUpdater on _$TaskDto {
//  static TaskDto fromEntity({required TaskEntity entity, required DateTime createdAt,
//  required DateTime changedAt, required String lastUpdatedBy, Color? color,}) =>
//  TaskDto(
//    id: entity.id,
//    text: entity.text,
//    importance: entity.importance,
//    done: entity.done,
//    deadline: entity.deadline,
//    createdAt: createdAt,
//    changedAt: changedAt,
//    lastUpdatedBy: lastUpdatedBy,
//    );
//}

@freezed
class TaskDto with _$TaskDto {
  const TaskDto._();
  @HiveType(typeId: 0, adapterName: 'TaskDtoAdapter')
  const factory TaskDto(
      {@HiveField(0)
          required String id,
      @HiveField(1)
          required String text,
      @HiveField(2)
          required Importance importance,
      @HiveField(3)
          DateTime? deadline,
      @HiveField(4)
          required bool done,
      @HiveField(5)
      @ColorConverter()
      @Default(Color(0xffffffff))
          Color? color,
      @HiveField(6)
      @TimestampConverter()
      @JsonKey(name: 'created_at')
          required DateTime createdAt,
      @HiveField(7)
      @TimestampConverter()
      @JsonKey(name: 'changed_at')
          required DateTime changedAt,
      @HiveField(8)
      @TimestampConverter()
      @JsonKey(name: 'last_updated_by')
          required String lastUpdatedBy}) = _TaskDto;
  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
  static List<TaskDto> listFromJson(List<Map<String, dynamic>> list) =>
      list.map(TaskDto.fromJson).toList();

  static TaskDto fromEntity({
    required TaskEntity entity,
    required DateTime createdAt,
    required DateTime changedAt,
    required String lastUpdatedBy,
    Color? color,
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

class TimestampConverter implements JsonConverter<DateTime, int> {
  const TimestampConverter();

  @override
  DateTime fromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp);

  @override
  int toJson(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
}

class ColorConverter implements JsonConverter<Color?, String?> {
  const ColorConverter();

  @override
  Color? fromJson(String? string) => string != null
      ? Color(int.parse(string.substring(string.indexOf('#') + 1), radix: 16))
      : null;

  @override
  String? toJson(Color? color) =>
      (color != null) ? '#${color.value.toRadixString(16)}' : null;
}
