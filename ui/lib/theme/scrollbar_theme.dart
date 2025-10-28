import 'package:flutter/material.dart';

class VisibleScrollbarTheme extends StatelessWidget {
  const VisibleScrollbarTheme({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        scrollbarTheme: theme.scrollbarTheme.copyWith(
          thumbVisibility: WidgetStateProperty.all<bool>(true),
        ),
      ),
      child: child,
    );
  }
}
