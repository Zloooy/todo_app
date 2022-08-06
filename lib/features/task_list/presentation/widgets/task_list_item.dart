import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_colors.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_text_styles.dart';
import 'package:todo_app/core/presentation/themes/extensions/red_checkbox_theme.dart';

class TaskListItem extends StatefulWidget {
  final TaskEntity task;
  final ValueChanged<bool> onChangeDone;
  final VoidCallback onDelete;
  TaskListItem(
      {Key? key,
      required this.task,
      required this.onChangeDone,
      required this.onDelete})
      : super(key: key);

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool _isDone = false;
  @override
  void didChangeDependencies() {
    setState(() {
      _isDone = widget.task.done;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final CheckboxThemeData redCheckboxTheme =
        Theme.of(context).extension<RedCheckboxTheme>()!.theme;
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    final TextStyle scratchTextStyle =
        Theme.of(context).extension<AdditionalTextStyles>()!.scratchStyle;
    final TextStyle regularTextStyle = Theme.of(context).textTheme.bodyLarge!;
    final Widget checkbox = Checkbox(
      value: _isDone,
      onChanged: (done) {
        bool nullSafeDone = done ?? false;
        setState(() => _isDone = nullSafeDone);
        widget.onChangeDone(nullSafeDone);
      },
    );
    return Dismissible(
      confirmDismiss: _confirmDismiss,
      onDismissed: _onDismiss,
      key: ValueKey(widget.task),
      background: ColoredBox(
        color: additionalColors.green,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Icon(
                  color: Theme.of(context).colorScheme.onSecondary,
                  Icons.check,
                ),
              ),
            )
          ],
        ),
      ),
      secondaryBackground: ColoredBox(
        color: additionalColors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 27),
                child: Icon(
                  color: Theme.of(context).colorScheme.onSecondary,
                  Icons.delete,
                ),
              ),
            )
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListTile(
          minLeadingWidth: 0,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: (!_isDone &&
                        widget.task.deadline != null &&
                        DateTime.now().millisecondsSinceEpoch >
                            widget.task.deadline!.millisecondsSinceEpoch)
                    ? CheckboxTheme(
                        data: redCheckboxTheme,
                        child: Container(
                          width: 14,
                          height: 17,
                          color: additionalColors.red.withOpacity(0.33),
                          child: checkbox,
                        ),
                      )
                    : SizedBox(width: 14, height: 17, child: checkbox),
              ),
            ],
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              // WidgetSpan(
                              //   alignment: PlaceholderAlignment.middle,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(right: 15),
                              //     child: task.status == TaskStatus.overdue
                              //         ? CheckboxTheme(
                              //             data: redCheckboxTheme,
                              //             child: Container(
                              //               width: 14,
                              //               height: 17,
                              //               color: additionalColors.red
                              //                   .withOpacity(0.33),
                              //               child: checkbox,
                              //             ),
                              //           )
                              //         : SizedBox(
                              //             width: 14,
                              //             height: 17,
                              //             child: checkbox),
                              //   ),
                              // ),
                              if (widget.task.importance != Importance.basic)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 6,
                                    ),
                                    child:
                                        _prioritySign(widget.task.importance)!,
                                  ),
                                ),
                              TextSpan(
                                  style: _isDone
                                      ? scratchTextStyle
                                      : regularTextStyle,
                                  text: widget.task.text),
                            ],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          subtitle: widget.task.deadline != null
              ? Text(AppLocalizations.of(context)!.date)
              : null,
          trailing: const Icon(Icons.info_outline),
        ),
      ),
    );
    // return Theme(
    //   data: task.status != TaskStatus.overdue
    //         ? regularCheckboxTheme
    //          : redCheckboxTheme,
    //   child: Dismissible(
    //    key: ValueKey(task),
    //    background: ColoredBox(color: additionalColors.green,
    //    child: Row(
    //      children: [
    //        Padding(
    //        padding: const EdgeInsets.all(27),
    //        child: Icon(
    //          color: Theme.of(context).colorScheme.onSecondary,
    //          Icons.check
    //          ),
    //      )]
    //      ),
    //    ),
    //    secondaryBackground: ColoredBox(color: additionalColors.red,
    //   child: Row(
    //      mainAxisAlignment: MainAxisAlignment.end,
    //      children: [Padding(
    //        padding: const EdgeInsets.all(27),
    //        child: Icon(
    //          color: Theme.of(context).colorScheme.onSecondary,
    //          Icons.delete
    //          ),
    //      )]
    //      )),
    //      child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
    //     child: Column(
    //       children: [
    //         Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                       width: 14,
    //                       height: 14,
    //                       color: additionalColors.red.withOpacity(0.33),
    //                       child: Checkbox(
    //                         value: task.status == TaskStatus.done,
    //                         onChanged: (_) {},
    //                       )),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 15),
    //                     child: IntrinsicWidth(
    //                       child: Row(
    //                         mainAxisSize: MainAxisSize.max,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           if (task.priority.show) _prioritySign(task.priority)!,
    //                             Expanded(child: Text(task.text, maxLines: 3, overflow: TextOverflow.ellipsis))
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               const Icon(Icons.info_outline),
    //             ]),
    //       ],
    //     ),
    //   )),
    // );
  }

  Widget? _prioritySign(Importance importance) {
    //const double boxWidth = 16, boxHeight = 20;
    //final double minSide = min(boxWidth, boxHeight);
    switch (importance) {
      case Importance.important:
        return SvgPicture.asset('assets/icons/double_exclamation_mark.svg');
      case Importance.low:
        return SvgPicture.asset('assets/icons/downward_arrow.svg');
      case Importance.basic:
        return null;
    }
  }

  Future<bool> _confirmDismiss(DismissDirection direction) {
    bool deleting = direction == DismissDirection.endToStart;
    if (!deleting) {
      setState(() {
        _isDone = true;
      });
    }
    widget.onChangeDone(_isDone);
    return Future.value(deleting);
  }

  void _onDismiss(DismissDirection direction) {
    if (direction == DismissDirection.endToStart) {
      widget.onDelete();
    } else if (direction == DismissDirection.startToEnd) {
      setState(() {
        _isDone = true;
      });
      widget.onChangeDone(_isDone);
    }
  }
}
