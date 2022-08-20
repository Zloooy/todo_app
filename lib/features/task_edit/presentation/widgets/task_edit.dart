import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/data/enum/importance.dart';
import 'package:todo_app/core/data/repository/task_repository.dart';
import 'package:todo_app/core/domain/entity/task_entity.dart';
import 'package:todo_app/core/presentation/edit_text.dart';
import 'package:todo_app/core/presentation/themes/extensions/additional_colors.dart';
import 'package:todo_app/features/task_edit/presentation/bloc/task_edit_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/task_edit/presentation/bloc/task_edit_state.dart';
import 'package:todo_app/features/task_edit/presentation/widgets/dropdown_list.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({Key? key}) : super(key: key);

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  late final ScrollController _controller;
  double offset = 0;
  bool get contentUnderAppBar => offset > 16;
  void scrollListener() {
    print("offset ${_controller.offset}");
    setState(() {
      offset = _controller.offset;
    });
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String? taskId =
        ModalRoute.of(context)!.settings.arguments as String?;
    final noContentUnderAppbarTheme = Theme.of(context)
        .appBarTheme
        .copyWith(elevation: 0, color: Theme.of(context).colorScheme.primary);
    final contentUnderAppbarTheme = Theme.of(context).appBarTheme.copyWith(
        scrolledUnderElevation: 4,
        shadowColor: Colors.black,
        color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary);
    final AdditionalColors addititonalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    return Theme(
        data: Theme.of(context).copyWith(
          appBarTheme: contentUnderAppBar
              ? contentUnderAppbarTheme
              : noContentUnderAppbarTheme,
        ),
        child: BlocProvider(
          create: (context) => TaskEditBloc(
              taskId: taskId,
              taskRepository: RepositoryProvider.of<TaskRepository>(context)),
          child: BlocBuilder<TaskEditBloc, TaskEditState>(
              builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 56,
                leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close)),
                actions: [
                  TextButton(
                    onPressed: () => BlocProvider.of<TaskEditBloc>(context)
                        .add(SaveTaskEvent()),
                    child: Text(
                      // TODO move to themes
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                      AppLocalizations.of(context)!.save.toUpperCase(),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                controller: _controller,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: state.loaded
                      ? state.task != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: EditText(
                                        hintText: AppLocalizations.of(context)!
                                            .isThereSomethingToDo,
                                        minLines: 3,
                                        initialText: state.task!.text,
                                        onChanged: (text) {
                                          BlocProvider.of<TaskEditBloc>(context)
                                              .add(ModifyTaskEvent(state.task!
                                                  .copyWith(text: text)));
                                        }),
                                  ),
                                ),
                                DropdownList<_ImportanceListItem>(
                                  items: [
                                    Importance.basic,
                                    Importance.low,
                                    Importance.important
                                  ]
                                      .map(
                                        (i) => _ImportanceListItem(
                                            title:
                                                _importanceString(context, i),
                                            value: i),
                                      )
                                      .toList(),
                                  itemBuilder: (BuildContext context,
                                          _ImportanceListItem item) =>
                                      Material(
                                    child: ListTile(title: Text(item.title)),
                                  ),
                                  onSelectItem: (item) =>
                                      BlocProvider.of<TaskEditBloc>(context)
                                          .add(ModifyTaskEvent(state.task!
                                              .copyWith(
                                                  importance: item.value))),
                                  child: SizedBox(
                                    height: 64,
                                    width:
                                        MediaQuery.of(context).size.width - 52,
                                    child: ListTile(
                                      title: Text(AppLocalizations.of(context)!
                                          .importance),
                                      subtitle: Text(_importanceString(
                                          context, state.task!.importance)),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  onTap: () => _pickDate(context, state.task!),
                                  title: Text(
                                      AppLocalizations.of(context)!.makeUpTo),
                                  subtitle: state.task!.deadline != null
                                      ? Text(
                                          style: TextStyle(
                                              color: addititonalColors.blue),
                                          _formatDate(state.task!.deadline!))
                                      : Text(AppLocalizations.of(context)!
                                          .dateNotDefined),
                                  trailing: Switch(
                                    value: state.task!.deadline != null,
                                    onChanged: (value) {
                                      if (!value) {
                                        BlocProvider.of<TaskEditBloc>(context)
                                            .add(ModifyTaskEvent(state.task!
                                                .copyWith(deadline: null)));
                                      }
                                    },
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  onTap: state.taskId != null
                                      ? () {
                                          BlocProvider.of<TaskEditBloc>(context)
                                              .add(
                                            DeleteTaskEvent(
                                              state.task!,
                                              () => Navigator.of(context).pop(),
                                            ),
                                          );
                                        }
                                      : null,
                                  leading: Icon(
                                      color: state.taskId != null
                                          ? addititonalColors.red
                                          : Theme.of(context).disabledColor,
                                      Icons.delete),
                                  title: Text(
                                      style: TextStyle(
                                          color: state.taskId != null
                                              ? addititonalColors.red
                                              : Theme.of(context)
                                                  .disabledColor),
                                      AppLocalizations.of(context)!.delete),
                                )
                              ],
                            )
                          : Center(
                              child: Text(
                                  AppLocalizations.of(context)!.taskNotFound))
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            );
          }),
        ));
  }

  String _formatDate(DateTime date) {
    // TODO использовать системную локаль
    //String dayFormat = DateFormat.d('ru_RU').format(date);
    //String monthFormat = DateFormat.MMMM('ru_RU').format(date);
    //String yearFormat = DateFormat.y('ru_RU').format(date);
    //return "$dayFormat $monthFormat $yearFormat";
    return DateFormat.yMMMMEEEEd('ru_RU').format(date);
  }

  String _importanceString(BuildContext context, Importance importance) {
    switch (importance) {
      case Importance.basic:
        return AppLocalizations.of(context)!.importanceBasic;
      case (Importance.important):
        return AppLocalizations.of(context)!.importanceImportant;
      case (Importance.low):
        return AppLocalizations.of(context)!.importanceLow;
    }
  }

  void _pickDate(BuildContext context, TaskEntity task) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      BlocProvider.of<TaskEditBloc>(context)
          .add(ModifyTaskEvent(task.copyWith(deadline: pickedDate)));
    }
  }
}

class _ImportanceListItem {
  final String title;
  final Importance value;
  _ImportanceListItem({required this.title, required this.value});
}
