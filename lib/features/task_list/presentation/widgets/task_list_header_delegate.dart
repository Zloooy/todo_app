import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/presentation/themes/extensions/blue_icon_theme.dart';

class TaskListHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxShrinkOffset = 50;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool expandedView = shrinkOffset < maxShrinkOffset;
    return (expandedView) ? SafeArea(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB((60-shrinkOffset).clamp(16, 60), 16, 16, 16),
                child:              
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocalizations.of(context)!.myTasks,
                            style: Theme.of(context).textTheme.titleLarge),
                       Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.tasksCompleted,
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                        IconTheme(
                        data: Theme.of(context).extension<BlueIconTheme>()!.theme,
                        child: const Icon(Icons.remove_red_eye_rounded))
                      ]
                        )
                      ],
                    ),
                ),
            ],
          ),
    )
        : Card(
          shape: RoundedRectangleBorder(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.myTasks,
                                  style: Theme.of(context).textTheme.labelLarge),
                      IconTheme(
                        data: Theme.of(context).extension<BlueIconTheme>()!.theme,
                        child: const Icon(Icons.remove_red_eye_rounded))
                ],
                ),
            ),
          ),
        );
  }

  @override
  double get maxExtent => 164;

  @override
  double get minExtent => 118;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}