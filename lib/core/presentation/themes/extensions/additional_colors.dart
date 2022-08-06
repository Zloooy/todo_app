import 'package:flutter/material.dart';

class AdditionalColors extends ThemeExtension<AdditionalColors> {
  AdditionalColors(
      {required this.green,
      required this.red,
      required this.blue,
      required this.transparentRed});
  final Color red;
  final Color blue;
  final Color green;
  final Color transparentRed;
  @override
  ThemeExtension<AdditionalColors> copyWith({
    Color? red,
    Color? blue,
    Color? green,
    Color? transparentRed,
  }) =>
      AdditionalColors(
        red: red ?? this.red,
        blue: blue ?? this.blue,
        green: green ?? this.green,
        transparentRed: transparentRed ?? this.transparentRed,
      );

  @override
  ThemeExtension<AdditionalColors> lerp(
    ThemeExtension<AdditionalColors>? other,
    double t,
  ) =>
      this;
}
