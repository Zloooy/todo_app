import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/presentation/themes/extensions/blue_icon_theme.dart';
import 'package:todo_app/features/task_list/presentation/widgets/visibility_icon.dart';

class TaskListHeaderDelegate extends SliverPersistentHeaderDelegate {
  const TaskListHeaderDelegate({
    required this.doneCount,
    required this.showDone,
    required this.onSwitchShowDone,
  });

  final int doneCount;
  final bool showDone;
  final VoidCallback onSwitchShowDone;
  final double maxShrinkOffset = 50;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final bool expandedView = shrinkOffset < maxShrinkOffset;
    return expandedView
        ? SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    (60 - shrinkOffset).clamp(16, 60),
                    16,
                    16,
                    16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.myTasks,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.tasksCompleted} ${doneCount}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          IconTheme(
                              data: Theme.of(context)
                                  .extension<BlueIconTheme>()!
                                  .theme,
                              child:
                                  _visibilityIcon(showDone, onSwitchShowDone))
                        ],
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
                    Text(
                      AppLocalizations.of(context)!.myTasks,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    IconTheme(
                        data:
                            Theme.of(context).extension<BlueIconTheme>()!.theme,
                        child: VisibilityIcon(
                            onSwitchShowDone: onSwitchShowDone,
                            showDone: showDone))
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
