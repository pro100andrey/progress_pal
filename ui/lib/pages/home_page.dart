import 'package:flutter/material.dart';

import '../drawers/app_drawer.dart';
import '../sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.isWaiting,
    required this.profileMenu,
    required this.child,
    required this.appDrawer,
    super.key,
  });

  final Widget child;
  final bool isWaiting;
  final Widget profileMenu;
  final AppDrawerVm appDrawer;

  @override
  Widget build(BuildContext context) => Sizer(
    maxTabletWidth: 1023,
    builder: (context, orientation, screenType) => Row(
      children: [
        if (screenType != ScreenType.mobile) AppDrawer(vm: appDrawer),
        Expanded(
          child: Scaffold(
            drawer: screenType == ScreenType.mobile
                ? AppDrawer(vm: appDrawer)
                : null,
            appBar: AppBar(
              title: Text(appDrawer.selectedItem.title),
              actions: [
                if (!isWaiting) profileMenu,
              ],
            ),
            body: child,
          ),
        ),
      ],
    ),
  );
}
