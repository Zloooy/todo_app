// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaskListState {
  List<TaskEntity> get tasks => throw _privateConstructorUsedError;
  bool get loaded => throw _privateConstructorUsedError;
  bool get showDone => throw _privateConstructorUsedError;
  int get doneCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskListStateCopyWith<TaskListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskListStateCopyWith<$Res> {
  factory $TaskListStateCopyWith(
          TaskListState value, $Res Function(TaskListState) then) =
      _$TaskListStateCopyWithImpl<$Res>;
  $Res call(
      {List<TaskEntity> tasks, bool loaded, bool showDone, int doneCount});
}

/// @nodoc
class _$TaskListStateCopyWithImpl<$Res>
    implements $TaskListStateCopyWith<$Res> {
  _$TaskListStateCopyWithImpl(this._value, this._then);

  final TaskListState _value;
  // ignore: unused_field
  final $Res Function(TaskListState) _then;

  @override
  $Res call({
    Object? tasks = freezed,
    Object? loaded = freezed,
    Object? showDone = freezed,
    Object? doneCount = freezed,
  }) {
    return _then(_value.copyWith(
      tasks: tasks == freezed
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskEntity>,
      loaded: loaded == freezed
          ? _value.loaded
          : loaded // ignore: cast_nullable_to_non_nullable
              as bool,
      showDone: showDone == freezed
          ? _value.showDone
          : showDone // ignore: cast_nullable_to_non_nullable
              as bool,
      doneCount: doneCount == freezed
          ? _value.doneCount
          : doneCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_TaskListStateCopyWith<$Res>
    implements $TaskListStateCopyWith<$Res> {
  factory _$$_TaskListStateCopyWith(
          _$_TaskListState value, $Res Function(_$_TaskListState) then) =
      __$$_TaskListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<TaskEntity> tasks, bool loaded, bool showDone, int doneCount});
}

/// @nodoc
class __$$_TaskListStateCopyWithImpl<$Res>
    extends _$TaskListStateCopyWithImpl<$Res>
    implements _$$_TaskListStateCopyWith<$Res> {
  __$$_TaskListStateCopyWithImpl(
      _$_TaskListState _value, $Res Function(_$_TaskListState) _then)
      : super(_value, (v) => _then(v as _$_TaskListState));

  @override
  _$_TaskListState get _value => super._value as _$_TaskListState;

  @override
  $Res call({
    Object? tasks = freezed,
    Object? loaded = freezed,
    Object? showDone = freezed,
    Object? doneCount = freezed,
  }) {
    return _then(_$_TaskListState(
      tasks: tasks == freezed
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskEntity>,
      loaded: loaded == freezed
          ? _value.loaded
          : loaded // ignore: cast_nullable_to_non_nullable
              as bool,
      showDone: showDone == freezed
          ? _value.showDone
          : showDone // ignore: cast_nullable_to_non_nullable
              as bool,
      doneCount: doneCount == freezed
          ? _value.doneCount
          : doneCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_TaskListState implements _TaskListState {
  _$_TaskListState(
      {required final List<TaskEntity> tasks,
      required this.loaded,
      required this.showDone,
      this.doneCount = 0})
      : _tasks = tasks;

  final List<TaskEntity> _tasks;
  @override
  List<TaskEntity> get tasks {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  final bool loaded;
  @override
  final bool showDone;
  @override
  @JsonKey()
  final int doneCount;

  @override
  String toString() {
    return 'TaskListState(tasks: $tasks, loaded: $loaded, showDone: $showDone, doneCount: $doneCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskListState &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality().equals(other.loaded, loaded) &&
            const DeepCollectionEquality().equals(other.showDone, showDone) &&
            const DeepCollectionEquality().equals(other.doneCount, doneCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(loaded),
      const DeepCollectionEquality().hash(showDone),
      const DeepCollectionEquality().hash(doneCount));

  @JsonKey(ignore: true)
  @override
  _$$_TaskListStateCopyWith<_$_TaskListState> get copyWith =>
      __$$_TaskListStateCopyWithImpl<_$_TaskListState>(this, _$identity);
}

abstract class _TaskListState implements TaskListState {
  factory _TaskListState(
      {required final List<TaskEntity> tasks,
      required final bool loaded,
      required final bool showDone,
      final int doneCount}) = _$_TaskListState;

  @override
  List<TaskEntity> get tasks;
  @override
  bool get loaded;
  @override
  bool get showDone;
  @override
  int get doneCount;
  @override
  @JsonKey(ignore: true)
  _$$_TaskListStateCopyWith<_$_TaskListState> get copyWith =>
      throw _privateConstructorUsedError;
}
