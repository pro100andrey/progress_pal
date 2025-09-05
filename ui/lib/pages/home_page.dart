import 'package:flutter/material.dart';

import '../drawers/app_drawer.dart';
import '../indicators/base_circle_indicator.dart';
import '../models/value_changed.dart';
import '../selectors/language_selector.dart';
import '../sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.userIsWaiting,
    required this.dataIsWaiting,
    required this.profileMenu,
    required this.child,
    required this.appDrawer,
    required this.language,
    super.key,
  });

  final Widget child;
  final bool userIsWaiting;
  final bool dataIsWaiting;
  final Widget profileMenu;
  final AppDrawerVm appDrawer;
  final ValueChangedWithItemsVm<LanguagePair> language;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final drawer = AppDrawer(
        vm: appDrawer,
        profileMenu: !userIsWaiting ? profileMenu : null,
      );

      return Stack(
        children: [
          Row(
            children: [
              if (Device.screenType != ScreenType.mobile) drawer,
              Expanded(
                child: Scaffold(
                  drawer: Device.screenType == ScreenType.mobile
                      ? drawer
                      : null,
                  appBar: AppBar(
                    title: Text(appDrawer.selectedItem.title),
                    centerTitle: false,
                    actions: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (dataIsWaiting) const BaseCircleIndicator(),
                          const SizedBox(width: 16),
                          LanguageSelector(vm: language),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ],
                  ),
                  body: child,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
