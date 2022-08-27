import 'package:flutter/material.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/presentation/assets/asset_provider.dart';

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
        return AssetProvider.double_exclamation_mark;
      case Importance.low:
        return AssetProvider.downward_arrow;
      case Importance.basic:
        return SizedBox();
    }
  }
}
