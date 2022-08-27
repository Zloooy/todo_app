import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/add_task_bloc/add_task_bloc.dart';
import 'package:todo_app/features/task_list/presentation/bloc/add_task_bloc/add_task_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskTextField extends StatefulWidget {
  final TextEditingController controller;
  const AddTaskTextField({required this.controller, super.key});

  @override
  _AddTaskTextFieldState createState() => _AddTaskTextFieldState();
}

class _AddTaskTextFieldState extends State<AddTaskTextField> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<_AddTaskTextFieldState> key =
      new GlobalKey<_AddTaskTextFieldState>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        BlocProvider.of<AddTaskBloc>(context).add(UnfocusTextEvent());
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AddTaskBloc, AddTaskState>(
        listener: (context, state) {
          if (state.text != widget.controller.text) {
            setState(() => widget.controller.text = state.text);
          }
        },
        builder: (context, state) {
          return TextField(
            key: key,
            focusNode: _focusNode,
            controller: widget.controller,
            onSubmitted: _onInputEnd(context),
            onChanged: (value) => BlocProvider.of<AddTaskBloc>(context).add(
              ChangeTextEvent(newText: value),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.of(context)!.newTask,
            ),
            maxLines: null,
          );
        },
      );
  void Function(String) _onInputEnd(BuildContext context) => (String text) {
        BlocProvider.of<AddTaskBloc>(context)
            .add(SubmitTextEvent(submittedText: text));
      };
}
