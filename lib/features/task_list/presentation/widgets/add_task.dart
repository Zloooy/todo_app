import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/add_task_bloc/add_task_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/add_task_bloc/add_task_state.dart';
import 'package:todo_app/features/task_list/presentation/bloc/task_list_bloc/task_list_bloc.dart';
import 'package:todo_app/features/task_list/presentation/widgets/add_task_text_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) =>
            AddTaskBloc(BlocProvider.of<TaskListBloc>(context)),
        child: Padding(
          padding: const EdgeInsets.all(
            12,
          ),
          child: ListTile(
            minLeadingWidth: 0,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: BlocBuilder<AddTaskBloc, AddTaskState>(
                    builder: (context, state) {
                      return IconButton(
                        iconSize: 20,
                        visualDensity: VisualDensity.compact,
                        constraints: BoxConstraints.loose(Size(20, 20)),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(0),
                        onPressed: () => _onInputEnd(context)(state.text),
                        icon: Icon(
                          Icons.add,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AddTaskTextField(controller: _controller),
                        ],
                      ),
                    ),
                  ],
                ),
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
