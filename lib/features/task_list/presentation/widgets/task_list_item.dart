import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_colors.dart';
import 'package:todo_app/core/presentation/themes/extensions/red_checkbox_theme.dart';
import 'package:todo_app/features/task_list/data/dto/short_task.dart';
class TaskListItem extends StatelessWidget {
  final ShortTask task;
  const TaskListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData regularCheckboxTheme = Theme.of(context);
    final ThemeData redCheckboxTheme =
        regularCheckboxTheme.extension<RedCheckboxTheme>()?.theme ??
            regularCheckboxTheme;
    final AdditionalColors additionalColors = Theme.of(context).extension<AdditionalColors>()!;
    return Theme(
        data: task.status != TaskStatus.overdue
            ? regularCheckboxTheme
            : redCheckboxTheme,
        child: Dismissible(
          key: ValueKey(task),
          background: ColoredBox(color: additionalColors.green,
          child: Row(
            children: [Padding(
              padding: const EdgeInsets.all(27),
              child: Icon(
                color: Theme.of(context).colorScheme.onSecondary,
                Icons.check
                ),
            )]
            ),
          ),
          secondaryBackground: ColoredBox(color: additionalColors.red,
         child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Padding(
              padding: const EdgeInsets.all(27),
              child: Icon(
                color: Theme.of(context).colorScheme.onSecondary,
                Icons.delete
                ),
            )]
            ) ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (task.priority.show) _prioritySign(task.priority)!,
                  Flexible(
                      child: Text(task.text,
                          maxLines: 3, overflow: TextOverflow.ellipsis)),
                ],
              ),
              subtitle: Text(AppLocalizations.of(context)!.date),
              secondary: const Icon(Icons.info_outline),
              value: task.status == TaskStatus.done,
              onChanged: (bool? value) {},
            ),
          ),
        ));
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Checkbox(value: task.status == TaskStatus.done, onChanged: (_){},),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 15),
    //           child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               if (task.priority.show) _prioritySign(task.priority)!,
    //               Text(task.text),
    //             ],
    //           ),
    //         ),
    //                 ],
    //               ),
    //         const Icon(Icons.info_outline),
    //         ]),
    //     ],
    //   ),
    // );
  }

  Widget? _prioritySign(TaskPriority priority) {
    const double boxWidth = 16, boxHeight = 20;
    final double minSide = min(boxWidth, boxHeight);
    switch (priority) {
      case (TaskPriority.high):
        return SvgPicture.asset('assets/icons/double_exclamation_mark.svg');
      case (TaskPriority.low):
        return SvgPicture.asset('assets/icons/downward_arrow.svg');
      case (TaskPriority.undefined):
        return null;
    }
  }
}