import 'package:flutter/material.dart';

class DropdownList<T> extends StatefulWidget {
  DropdownList(
      {required this.itemBuilder,
      required Widget this.child,
      required this.items,
      super.key});
  final Widget child;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  @override
  _DropdownListState<T> createState() => _DropdownListState<T>();
}

class _DropdownListState<T> extends State<DropdownList<T>> {
  bool isMenuOpen = false;
  late GlobalKey _key;
  late OverlayEntry _overlayEntry;
  late Size widgetSize;
  late Offset widgetPosition;
  @override
  void initState() {
    _key = LabeledGlobalKey('button_widget');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _key,
      onTap: () => setState(() {
        if (isMenuOpen) {
          closeMenu();
        } else {
          openMenu();
        }
      }),
      child: widget.child,
    );
  }

  void openMenu() {
    findWidget();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void findWidget() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    widgetSize = renderBox.size;
    widgetPosition = renderBox.localToGlobal(Offset.zero);
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: widgetPosition.dx,
        top: widgetPosition.dy,
        child: SizedBox(
          width: 164,
          child: Card(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, i) => InkWell(
                onTap: () => this.closeMenu(),
                child: widget.itemBuilder(context, widget.items[i]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
