import 'package:flutter/material.dart';

class BlueIconTheme extends ThemeExtension<BlueIconTheme> {
  final IconThemeData theme;
  BlueIconTheme({required this.theme});
  @override
  ThemeExtension<BlueIconTheme> copyWith({IconThemeData? theme}) =>
      BlueIconTheme(theme: theme ?? this.theme);

  @override
  ThemeExtension<BlueIconTheme> lerp(
    ThemeExtension<BlueIconTheme>? other,
    double t,
  ) =>
      this;
}
