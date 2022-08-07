import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, int> {
  const TimestampConverter();

  @override
  DateTime fromJson(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp);

  @override
  int toJson(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
}
