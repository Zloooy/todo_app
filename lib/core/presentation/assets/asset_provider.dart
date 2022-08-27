import 'package:flutter_svg/svg.dart';

abstract class AssetProvider {
  static const String _double_exclamation_mark_path='assets/icons/double_exclamation_mark.svg';
  static const String _downward_arrow_path = 'assets/icons/downward_arrow.svg';
  static final SvgPicture double_exclamation_mark = SvgPicture.asset(_double_exclamation_mark_path);
  static final SvgPicture downward_arrow = SvgPicture.asset(_downward_arrow_path);
}