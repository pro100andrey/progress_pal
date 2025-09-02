import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../drawers/app_drawer.dart';
import '../sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.userIsWaiting,
    required this.dataIsWaiting,
    required this.profileMenu,
    required this.child,
    required this.appDrawer,
    super.key,
  });

  final Widget child;
  final bool userIsWaiting;
  final bool dataIsWaiting;
  final Widget profileMenu;
  final AppDrawerVm appDrawer;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => Stack(
      children: [
        Row(
          children: [
            if (Device.screenType != ScreenType.mobile)
              AppDrawer(
                vm: appDrawer,
                profileMenu: !userIsWaiting ? profileMenu : null,
              ),
            Expanded(
              child: Scaffold(
                drawer: Device.screenType == ScreenType.mobile
                    ? AppDrawer(
                        vm: appDrawer,
                        profileMenu: !userIsWaiting ? profileMenu : null,
                      )
                    : null,
                appBar: AppBar(
                  title: Text(appDrawer.selectedItem.title),
                ),
                body: child,
              ),
            ),
          ],
        ),
        if (dataIsWaiting)
          ShadProgress(
            minHeight: 2,
            color: ShadTheme.of(context).colorScheme.selection,
            backgroundColor: Colors.transparent,
          ),
      ],
    ),
  );
}
