import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../drawers/app_drawer.dart';
import '../indicators/base_circle_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.drawerItem,
    required this.dataIsWaiting,
    required this.child,
    required this.drawer,
    required this.languageSelector,
    super.key,
  });

  final DrawerItem drawerItem;
  final bool dataIsWaiting;
  final Widget child;
  final Widget drawer;
  final Widget languageSelector;

  @override
  Widget build(BuildContext context) {
    final sm = context.breakpoint <= ShadTheme.of(context).breakpoints.sm;

    return Row(
      children: [
        if (!sm) drawer,
        Expanded(
          child: Scaffold(
            drawer: sm ? drawer : null,
            appBar: AppBar(
              title: Text(drawerItem.title),
              centerTitle: false,
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (dataIsWaiting) const BaseCircleIndicator(),
                    const SizedBox(width: 16),
                    languageSelector,
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
            body: child,
          ),
        ),
      ],
    );
  }
}
