import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color?, String?> {
  const ColorConverter();

  @override
  Color? fromJson(String? string) => string != null
      ? Color(int.parse(
          string.substring(string.indexOf('#') + 1),
          radix: 16,
        ))
      : null;

  @override
  String? toJson(Color? color) =>
      (color != null) ? '#${color.value.toRadixString(16)}' : null;
}
