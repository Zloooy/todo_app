import 'package:flutter/material.dart';

class AdditionalTextStyles extends ThemeExtension<AdditionalTextStyles> {
  final TextStyle scratchStyle;
  AdditionalTextStyles({
    required this.scratchStyle,
  });
  @override
  ThemeExtension<AdditionalTextStyles> copyWith({TextStyle? scratchStyle}) =>
      AdditionalTextStyles(scratchStyle: scratchStyle ?? this.scratchStyle);

  @override
  ThemeExtension<AdditionalTextStyles> lerp(
    ThemeExtension<AdditionalTextStyles>? other,
    double t,
  ) =>
      this;
}
