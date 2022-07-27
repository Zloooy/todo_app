import 'package:flutter/material.dart';
class RedCheckboxTheme extends ThemeExtension<RedCheckboxTheme> {
  final ThemeData theme;
  RedCheckboxTheme({required this.theme});
  @override
  ThemeExtension<RedCheckboxTheme> copyWith({ThemeData? theme}) =>
      RedCheckboxTheme(theme: theme ?? this.theme);

  @override
  ThemeExtension<RedCheckboxTheme> lerp(
          ThemeExtension<RedCheckboxTheme>? other, double t) =>
      this;
}