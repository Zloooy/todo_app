import 'dart:ui';
import 'color_set.dart';

class LightColorSet extends ColorSet {
  const LightColorSet();
  @override
  Color get supportSeparator => const Color(0x33000000);
  @override
  Color get supportOverlay => const Color(0x0f000000);
  @override
  Color get labelPrimary => const Color(0xff000000);
  @override
  Color get labelSecondary => const Color(0x99000000);
  @override
  Color get labelTertiary => const Color(0x4d000000);
  @override
  Color get labelDisable => const Color(0x26000000);
  @override
  Color get colorRed => const Color(0xffff3b30);
  @override
  Color get colorGreen => const Color(0xff34c759);
  @override
  Color get colorBlue => const Color(0xff007aff);
  @override
  Color get colorGray => const Color(0xff8e8e93);
  @override
  Color get colorGrayLight => const Color(0xffd1d1d6);
  @override
  Color get colorWhite => const Color(0xffffffff);
  @override
  Color get backPrimary => const Color(0xfff7f6f2);
  @override
  Color get backSecondary => const Color(0xffffffff);
  @override
  Color get backElevated => const Color(0xffffffff);
}