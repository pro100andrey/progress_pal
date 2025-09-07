import 'package:flutter/material.dart';

import '../indicators/base_circle_indicator.dart';
import '../sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.tabTitle,
    required this.dataIsWaiting,
    required this.child,
    required this.drawer,
    required this.languageSelector,
    super.key,
  });

  final String tabTitle;
  final bool dataIsWaiting;
  final Widget child;
  final Widget drawer;
  final Widget languageSelector;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => Stack(
      children: [
        Row(
          children: [
            if (Device.screenType != ScreenType.mobile) drawer,
            Expanded(
              child: Scaffold(
                drawer: Device.screenType == ScreenType.mobile ? drawer : null,
                appBar: AppBar(
                  title: Text(tabTitle),
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
        ),
      ],
    ),
  );
}
