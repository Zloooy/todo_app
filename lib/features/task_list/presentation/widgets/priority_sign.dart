import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/data/enum/importance.dart';

class PrioritySign extends StatelessWidget {
  const PrioritySign({
    required this.importance,
    super.key,
  });

  final Importance importance;

  @override
  Widget build(BuildContext context) {
    switch (this.importance) {
      case Importance.important:
        return SvgPicture.asset('assets/icons/double_exclamation_mark.svg');
      case Importance.low:
        return SvgPicture.asset('assets/icons/downward_arrow.svg');
      case Importance.basic:
        return SizedBox();
    }
  }
}
