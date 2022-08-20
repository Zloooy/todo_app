import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_colors.dart';
import 'package:todo_app/features/task_list/presentation/widgets/visibility_icon.dart';

class TaskListHeaderDelegate extends SliverPersistentHeaderDelegate {
  const TaskListHeaderDelegate({
    required this.doneCount,
    required this.showDone,
    required this.onSwitchShowDone,
    required this.onSwitchTheme,
  });

  final int doneCount;
  final bool showDone;
  final VoidCallback onSwitchShowDone;
  final VoidCallback onSwitchTheme;
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
                            data: Theme.of(context).iconTheme.copyWith(
                                color: Theme.of(context)
                                    .extension<AdditionalColors>()!
                                    .blue),
                            child: VisibilityIcon(
                              onLongPress: onSwitchTheme,
                              showDone: showDone,
                              onSwitchShowDone: onSwitchShowDone,
                            ),
                          )
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
                        data: Theme.of(context).iconTheme.copyWith(
                            color: Theme.of(context)
                                .extension<AdditionalColors>()!
                                .blue),
                        child: VisibilityIcon(
                            onLongPress: onSwitchTheme,
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
