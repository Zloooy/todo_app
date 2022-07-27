import 'package:flutter/material.dart';
class AdditionalColors extends ThemeExtension<AdditionalColors> {
  final Color red;
  final Color blue;
  final Color green;
  AdditionalColors({required this.red, required this.blue, required this.green});
  @override
  ThemeExtension<AdditionalColors> copyWith({Color? red, Color? blue, Color? green}) =>
      AdditionalColors(red: red ?? this.red, blue: blue ?? this.blue, green: green ?? this.green);

  @override
  ThemeExtension<AdditionalColors> lerp(
          ThemeExtension<AdditionalColors>? other, double t) =>
      this;
}