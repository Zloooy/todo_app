import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'importance.g.dart';

@HiveType(typeId: 1)
enum Importance {
  @HiveField(0)
  @JsonValue("low")
  low,
  @HiveField(1)
  @JsonValue("basic")
  basic,
  @HiveField(2)
  @JsonValue("important")
  important;
}
