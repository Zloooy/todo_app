import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTask extends StatefulWidget {
  final void Function(String) onInputEnd;
  AddTask({required this.onInputEnd, super.key});

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
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: ListTile(
          minLeadingWidth: 0,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () => _onInputEnd(_controller.text),
                      icon: Icon(Icons.add))),
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
                        TextField(
                          controller: _controller,
                          onSubmitted: _onInputEnd,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.newTask),
                          maxLines: null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  void _onInputEnd(String text) {
    widget.onInputEnd(text);
    setState(() {
      _controller.clear();
    });
  }
}
