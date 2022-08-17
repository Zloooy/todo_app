import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/features/task_list/presentation/bloc/add_task_bloc/add_task_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/add_task_bloc/add_task_state.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_bloc.dart';

//     return TextFormField(
//       key: UniqueKey(),
//       controller: textController,
//       onChanged: (value)=>BlocProvider.of<AddTaskBloc>(context).add(ChangeTextEvent(newText: value)),
//       onFieldSubmitted: (value)=>BlocProvider.of<AddTaskBloc>(context).add(SubmitTextEvent(submittedText: value))
//     );

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) =>
            AddTaskBloc(BlocProvider.of<TaskListBloc>(context)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListTile(
            minLeadingWidth: 0,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: BlocBuilder<AddTaskBloc, AddTaskState>(
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () => _onInputEnd(context)(state.text),
                            icon: Icon(Icons.add),);
                      },
                    )),
              ],
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocListener<AddTaskBloc, AddTaskState>(
                            listener: (context, state) {
                              if (state.text != _controller.text) {
                                setState(() => _controller.text = state.text);
                              }
                            },
                            child: BlocBuilder<AddTaskBloc, AddTaskState>(
                              builder: (context, state) {
                                return TextField(
                                  key: UniqueKey(),
                                  controller: _controller,
                                  onSubmitted: _onInputEnd(context),
                                  onChanged: (value) {
                                    BlocProvider.of<AddTaskBloc>(context)
                                        .add(ChangeTextEvent(newText: value));
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)!
                                          .newTask),
                                  maxLines: null,
                                );
                              },
                            ),
                          ),
                        ]),
                  ),
                ])
              ],
            ),
          ),
        ),
      );

  void Function(String) _onInputEnd(BuildContext context) => (String text) {
        BlocProvider.of<AddTaskBloc>(context)
            .add(SubmitTextEvent(submittedText: text));
      };
}
