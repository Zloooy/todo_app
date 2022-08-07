import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisibilityIcon extends StatelessWidget {
  const VisibilityIcon({
    required this.onSwitchShowDone,
    required this.showDone,
    super.key,
  });

  final VoidCallback onSwitchShowDone;
  final bool showDone;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onSwitchShowDone,
        child: showDone
            ? SvgPicture.asset('assets/icons/visibility.svg')
            : SvgPicture.asset('assets/icons/visibility_off.svg'),
      );
}
