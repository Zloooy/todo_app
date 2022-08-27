import 'package:json_annotation/json_annotation.dart';

class NullableTimestampConverter implements JsonConverter<DateTime?, int?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(int? timestamp) => (timestamp != null)
      ? DateTime.fromMillisecondsSinceEpoch(timestamp)
      : null;

  @override
  int? toJson(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;
}
