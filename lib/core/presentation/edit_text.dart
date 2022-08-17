import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String? initialText;
  final bool Function(TextEditingController) onSubmit;
  final bool Function(TextEditingController) onInputEnd;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final int? minLines;
  EditText(
      {bool Function(TextEditingController)? onSubmit,
      bool Function(TextEditingController)? onInputEnd,
      ValueChanged<String>? onChanged,
      this.initialText,
      this.hintText,
      this.minLines,
      super.key})
      : onSubmit = (onSubmit ?? (_) => false),
        onInputEnd = (onInputEnd ?? (_) => false),
        onChanged = (onChanged ?? (_) {});

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _controller.text = widget.initialText ?? '';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: setStateIfNeeded(widget.onSubmit),
      onChanged: widget.onChanged,
      onEditingComplete: setStateIfNeededVoid(widget.onInputEnd),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
      ),
      minLines: widget.minLines,
      maxLines: null,
    );
  }

  VoidCallback setStateIfNeededVoid(
          bool Function(TextEditingController) onAction) =>
      () {
        if (onAction(this._controller)) {
          this.setState(() {});
        }
      };

  ValueChanged<String> setStateIfNeeded(
          bool Function(TextEditingController) onAction) =>
      (_) {
        if (onAction(this._controller)) {
          this.setState(() {});
        }
      };
}
