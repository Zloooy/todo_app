// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDtoAdapter extends TypeAdapter<_$_TaskDto> {
  @override
  final int typeId = 0;

  @override
  _$_TaskDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_TaskDto(
      id: fields[0] as String,
      text: fields[1] as String,
      importance: fields[2] as Importance,
      deadline: fields[3] as DateTime?,
      done: fields[4] as bool,
      color: fields[5] as Color?,
      createdAt: fields[6] as DateTime,
      changedAt: fields[7] as DateTime,
      lastUpdatedBy: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_TaskDto obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.importance)
      ..writeByte(3)
      ..write(obj.deadline)
      ..writeByte(4)
      ..write(obj.done)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.changedAt)
      ..writeByte(8)
      ..write(obj.lastUpdatedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskDto _$$_TaskDtoFromJson(Map<String, dynamic> json) => _$_TaskDto(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: $enumDecode(_$ImportanceEnumMap, json['importance']),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      done: json['done'] as bool,
      color: json['color'] == null
          ? const Color(0xffffffff)
          : const ColorConverter().fromJson(json['color'] as String?),
      createdAt: const TimestampConverter().fromJson(json['created_at'] as int),
      changedAt: const TimestampConverter().fromJson(json['changed_at'] as int),
      lastUpdatedBy: json['last_updated_by'] as String,
    );

Map<String, dynamic> _$$_TaskDtoToJson(_$_TaskDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': _$ImportanceEnumMap[instance.importance]!,
      'deadline': instance.deadline?.toIso8601String(),
      'done': instance.done,
      'color': const ColorConverter().toJson(instance.color),
      'created_at': const TimestampConverter().toJson(instance.createdAt),
      'changed_at': const TimestampConverter().toJson(instance.changedAt),
      'last_updated_by': instance.lastUpdatedBy,
    };

const _$ImportanceEnumMap = {
  Importance.low: 'low',
  Importance.basic: 'basic',
  Importance.important: 'important',
};
