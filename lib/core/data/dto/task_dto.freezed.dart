// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) {
  return _TaskDto.fromJson(json);
}

/// @nodoc
mixin _$TaskDto {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get text => throw _privateConstructorUsedError;
  @HiveField(2)
  Importance get importance => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime? get deadline => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get done => throw _privateConstructorUsedError;
  @HiveField(5)
  @ColorConverter()
  Color? get color => throw _privateConstructorUsedError;
  @HiveField(6)
  @TimestampConverter()
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(7)
  @TimestampConverter()
  @JsonKey(name: 'changed_at')
  DateTime get changedAt => throw _privateConstructorUsedError;
  @HiveField(8)
  @TimestampConverter()
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskDtoCopyWith<TaskDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDtoCopyWith<$Res> {
  factory $TaskDtoCopyWith(TaskDto value, $Res Function(TaskDto) then) =
      _$TaskDtoCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0)
          String id,
      @HiveField(1)
          String text,
      @HiveField(2)
          Importance importance,
      @HiveField(3)
          DateTime? deadline,
      @HiveField(4)
          bool done,
      @HiveField(5)
      @ColorConverter()
          Color? color,
      @HiveField(6)
      @TimestampConverter()
      @JsonKey(name: 'created_at')
          DateTime createdAt,
      @HiveField(7)
      @TimestampConverter()
      @JsonKey(name: 'changed_at')
          DateTime changedAt,
      @HiveField(8)
      @TimestampConverter()
      @JsonKey(name: 'last_updated_by')
          String lastUpdatedBy});
}

/// @nodoc
class _$TaskDtoCopyWithImpl<$Res> implements $TaskDtoCopyWith<$Res> {
  _$TaskDtoCopyWithImpl(this._value, this._then);

  final TaskDto _value;
  // ignore: unused_field
  final $Res Function(TaskDto) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
    Object? done = freezed,
    Object? color = freezed,
    Object? createdAt = freezed,
    Object? changedAt = freezed,
    Object? lastUpdatedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedBy: lastUpdatedBy == freezed
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TaskDtoCopyWith<$Res> implements $TaskDtoCopyWith<$Res> {
  factory _$$_TaskDtoCopyWith(
          _$_TaskDto value, $Res Function(_$_TaskDto) then) =
      __$$_TaskDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0)
          String id,
      @HiveField(1)
          String text,
      @HiveField(2)
          Importance importance,
      @HiveField(3)
          DateTime? deadline,
      @HiveField(4)
          bool done,
      @HiveField(5)
      @ColorConverter()
          Color? color,
      @HiveField(6)
      @TimestampConverter()
      @JsonKey(name: 'created_at')
          DateTime createdAt,
      @HiveField(7)
      @TimestampConverter()
      @JsonKey(name: 'changed_at')
          DateTime changedAt,
      @HiveField(8)
      @TimestampConverter()
      @JsonKey(name: 'last_updated_by')
          String lastUpdatedBy});
}

/// @nodoc
class __$$_TaskDtoCopyWithImpl<$Res> extends _$TaskDtoCopyWithImpl<$Res>
    implements _$$_TaskDtoCopyWith<$Res> {
  __$$_TaskDtoCopyWithImpl(_$_TaskDto _value, $Res Function(_$_TaskDto) _then)
      : super(_value, (v) => _then(v as _$_TaskDto));

  @override
  _$_TaskDto get _value => super._value as _$_TaskDto;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
    Object? done = freezed,
    Object? color = freezed,
    Object? createdAt = freezed,
    Object? changedAt = freezed,
    Object? lastUpdatedBy = freezed,
  }) {
    return _then(_$_TaskDto(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      importance: importance == freezed
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance,
      deadline: deadline == freezed
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: done == freezed
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changedAt: changedAt == freezed
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastUpdatedBy: lastUpdatedBy == freezed
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'TaskDtoAdapter')
class _$_TaskDto extends _TaskDto {
  const _$_TaskDto(
      {@HiveField(0)
          required this.id,
      @HiveField(1)
          required this.text,
      @HiveField(2)
          required this.importance,
      @HiveField(3)
          this.deadline,
      @HiveField(4)
          required this.done,
      @HiveField(5)
      @ColorConverter()
          this.color = const Color(0xffffffff),
      @HiveField(6)
      @TimestampConverter()
      @JsonKey(name: 'created_at')
          required this.createdAt,
      @HiveField(7)
      @TimestampConverter()
      @JsonKey(name: 'changed_at')
          required this.changedAt,
      @HiveField(8)
      @TimestampConverter()
      @JsonKey(name: 'last_updated_by')
          required this.lastUpdatedBy})
      : super._();

  factory _$_TaskDto.fromJson(Map<String, dynamic> json) =>
      _$$_TaskDtoFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String text;
  @override
  @HiveField(2)
  final Importance importance;
  @override
  @HiveField(3)
  final DateTime? deadline;
  @override
  @HiveField(4)
  final bool done;
  @override
  @JsonKey()
  @HiveField(5)
  @ColorConverter()
  final Color? color;
  @override
  @HiveField(6)
  @TimestampConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @HiveField(7)
  @TimestampConverter()
  @JsonKey(name: 'changed_at')
  final DateTime changedAt;
  @override
  @HiveField(8)
  @TimestampConverter()
  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  @override
  String toString() {
    return 'TaskDto(id: $id, text: $text, importance: $importance, deadline: $deadline, done: $done, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskDto &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality()
                .equals(other.importance, importance) &&
            const DeepCollectionEquality().equals(other.deadline, deadline) &&
            const DeepCollectionEquality().equals(other.done, done) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.changedAt, changedAt) &&
            const DeepCollectionEquality()
                .equals(other.lastUpdatedBy, lastUpdatedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(importance),
      const DeepCollectionEquality().hash(deadline),
      const DeepCollectionEquality().hash(done),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(changedAt),
      const DeepCollectionEquality().hash(lastUpdatedBy));

  @JsonKey(ignore: true)
  @override
  _$$_TaskDtoCopyWith<_$_TaskDto> get copyWith =>
      __$$_TaskDtoCopyWithImpl<_$_TaskDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskDtoToJson(
      this,
    );
  }
}

abstract class _TaskDto extends TaskDto {
  const factory _TaskDto(
      {@HiveField(0)
          required final String id,
      @HiveField(1)
          required final String text,
      @HiveField(2)
          required final Importance importance,
      @HiveField(3)
          final DateTime? deadline,
      @HiveField(4)
          required final bool done,
      @HiveField(5)
      @ColorConverter()
          final Color? color,
      @HiveField(6)
      @TimestampConverter()
      @JsonKey(name: 'created_at')
          required final DateTime createdAt,
      @HiveField(7)
      @TimestampConverter()
      @JsonKey(name: 'changed_at')
          required final DateTime changedAt,
      @HiveField(8)
      @TimestampConverter()
      @JsonKey(name: 'last_updated_by')
          required final String lastUpdatedBy}) = _$_TaskDto;
  const _TaskDto._() : super._();

  factory _TaskDto.fromJson(Map<String, dynamic> json) = _$_TaskDto.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get text;
  @override
  @HiveField(2)
  Importance get importance;
  @override
  @HiveField(3)
  DateTime? get deadline;
  @override
  @HiveField(4)
  bool get done;
  @override
  @HiveField(5)
  @ColorConverter()
  Color? get color;
  @override
  @HiveField(6)
  @TimestampConverter()
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @HiveField(7)
  @TimestampConverter()
  @JsonKey(name: 'changed_at')
  DateTime get changedAt;
  @override
  @HiveField(8)
  @TimestampConverter()
  @JsonKey(name: 'last_updated_by')
  String get lastUpdatedBy;
  @override
  @JsonKey(ignore: true)
  _$$_TaskDtoCopyWith<_$_TaskDto> get copyWith =>
      throw _privateConstructorUsedError;
}
