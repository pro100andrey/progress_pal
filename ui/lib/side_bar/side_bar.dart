import 'package:flutter/material.dart';

enum SideBarAlignment { left, right }

Future<T?> showSideBar<T>(
  BuildContext context, {
  required SideBar child,
  SideBarAlignment alignment = SideBarAlignment.right,
  BoxConstraints? constraints,
}) async {
  final effectiveConstraints =
      constraints ??
      const BoxConstraints(
        minWidth: 300,
        maxWidth: 400,
      );

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) => Align(
      alignment: alignment.alignment,
      child: ConstrainedBox(
        constraints: effectiveConstraints,
        child: Material(
          child: Stack(
            children: [
              child,
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: alignment.slideBeginOffset,
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    this.title,
    this.content,
    this.padding,
  });

  /// The title widget displayed at the top of the side bar.
  final Widget? title;

  /// The main content of the side bar.
  final Widget? content;

  /// Padding around the content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final padding = this.padding ?? const EdgeInsets.all(16);

    return Padding(
      padding: padding,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            DefaultTextStyle(
              style: Theme.of(context).textTheme.headlineSmall!,
              child: title!,
            ),
          if (content != null) Expanded(child: content!),
        ],
      ),
    );
  }
}

extension on SideBarAlignment {
  Alignment get alignment {
    switch (this) {
      case SideBarAlignment.left:
        return Alignment.centerLeft;
      case SideBarAlignment.right:
        return Alignment.centerRight;
    }
  }

  Offset get slideBeginOffset {
    switch (this) {
      case SideBarAlignment.left:
        return const Offset(-1, 0);
      case SideBarAlignment.right:
        return const Offset(1, 0);
    }
  }
}
