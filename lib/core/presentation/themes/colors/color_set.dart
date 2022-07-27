import 'dart:ui';

abstract class ColorSet {
  const ColorSet();
  Color get supportSeparator;
  Color get supportOverlay;
  Color get labelPrimary;
  Color get labelSecondary;
  Color get labelTertiary;
  Color get labelDisable;
  Color get colorRed;
  Color get colorGreen;
  Color get colorBlue;
  Color get colorGray;
  Color get colorGrayLight;
  Color get colorWhite;
  Color get backPrimary;
  Color get backSecondary;
  Color get backElevated;
}