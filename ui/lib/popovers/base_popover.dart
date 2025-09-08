import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

typedef BasePopoverBuilder =
    Widget Function(BuildContext context, ShadPopoverController controller);

class BasePopover extends StatefulWidget {
  const BasePopover({
    required this.builder,
    required this.popover,
    this.constraints = const BoxConstraints(),
    this.anchor,
    this.padding,
    super.key,
  });

  final BoxConstraints constraints;
  final BasePopoverBuilder builder;
  final BasePopoverBuilder popover;
  final ShadAnchorBase? anchor;
  final EdgeInsetsGeometry? padding;

  @override
  State<BasePopover> createState() => _BasePopoverState();
}

class _BasePopoverState extends State<BasePopover> {
  final _controller = ShadPopoverController();

  @override
  Widget build(BuildContext context) => ShadPopover(
    
    padding: widget.padding,
    anchor: widget.anchor,
    controller: _controller,
    popover: (context) => ConstrainedBox(
      constraints: widget.constraints,
      child: widget.popover(context, _controller),
    ),
    child: widget.builder(context, _controller),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

typedef ActionsPopoverBuilder =
    List<Widget> Function(
      BuildContext context,
      ShadPopoverController controller,
    );

final class ActionsPopover extends BasePopover {
  ActionsPopover({
    required super.builder,
    required ActionsPopoverBuilder actionsBuilder,
    super.anchor = const ShadAnchorAuto(
      targetAnchor: Alignment.topCenter,
    ),
    super.key,
  }) : super(
         padding: const EdgeInsets.all(8),
         constraints: const BoxConstraints(maxWidth: 200),
         popover: (context, controller) => Column(
           spacing: 8,
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: actionsBuilder(context, controller),
         ),
       );
}
