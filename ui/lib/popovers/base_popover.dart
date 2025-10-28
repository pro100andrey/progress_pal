import 'package:flutter/material.dart';

typedef PopoverChildBuilder =
    Widget Function(BuildContext context, MenuController controller);

typedef PopoverMenuChildrenBuilder =
    List<Widget> Function(BuildContext context, MenuController controller);

class BasePopover extends StatefulWidget {
  const BasePopover({
    required this.child,
    required this.menuChildren,
    this.alignmentOffset,
    this.alignment,

    super.key,
  });

  final PopoverChildBuilder child;
  final PopoverMenuChildrenBuilder menuChildren;
  final Offset? alignmentOffset;
  final AlignmentGeometry? alignment;

  @override
  State<BasePopover> createState() => _BasePopoverState();
}

class _BasePopoverState extends State<BasePopover> {
  final _controller = MenuController();

  @override
  Widget build(BuildContext context) => MenuAnchor(
    alignmentOffset: widget.alignmentOffset,
    style: MenuStyle(
      alignment: widget.alignment,
    ),
    menuChildren: widget.menuChildren(context, _controller),
    controller: _controller,
    child: widget.child(context, _controller),
  );

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

Widget constrainedMenuButton(
  Widget child, {
  double minWidth = 100,
  double minHeight = 0,
}) => ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: minWidth,
    minHeight: minHeight,
  ),
  child: child,
);
