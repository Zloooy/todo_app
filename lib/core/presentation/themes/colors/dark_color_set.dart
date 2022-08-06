import 'dart:ui';
import 'color_set.dart';

class DarkColorSet extends ColorSet {
  const DarkColorSet();
  @override
  Color get supportSeparator => const Color(0x33ffffff);
  @override
  Color get supportOverlay => const Color(0x52000000);
  @override
  Color get labelPrimary => const Color(0xffffffff);
  @override
  Color get labelSecondary => const Color(0x99ffffff);
  @override
  Color get labelTertiary => const Color(0x66ffffff);
  @override
  Color get labelDisable => const Color(0x26ffffff);
  @override
  Color get colorRed => const Color(0xffff453a);
  @override
  Color get colorGreen => const Color(0xff32d748);
  @override
  Color get colorBlue => const Color(0xff0a84ff);
  @override
  Color get colorGray => const Color(0xff8e8e93);
  @override
  Color get colorGrayLight => const Color(0xff48484a);
  @override
  Color get colorWhite => const Color(0xffffffff);
  @override
  Color get backPrimary => const Color(0xff161618);
  @override
  Color get backSecondary => const Color(0xff252528);
  @override
  Color get backElevated => const Color(0xff3c3c3f);
}
