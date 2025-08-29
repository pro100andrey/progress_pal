import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../generated/assets.gen.dart';
import '../sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.isWaiting,

    required this.profileMenu,
    super.key,
  });

  final bool isWaiting;
  final Widget profileMenu;

  @override
  Widget build(BuildContext context) => Sizer(
    maxTabletWidth: 1023,
    builder: (context, orientation, screenType) => Row(
      children: [
        if (screenType != ScreenType.mobile) const AppDrawer(),

        Expanded(
          child: Scaffold(
            drawer: screenType == ScreenType.mobile ? const AppDrawer() : null,
            appBar: AppBar(
              actions: [
                if (!isWaiting) profileMenu,
              ],
            ),
            body: Center(
              child: Text('${orientation.name} ${screenType.name}'),
            ),
          ),
        ),
      ],
    ),
  );
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    clipBehavior: Clip.none,
    shape: const RoundedRectangleBorder(),
    elevation: 0,
    width: 200,
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: ShadTheme.of(context).colorScheme.border,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Assets.svg.logo.noBg.svg(width: 28, height: 28),
                Text(
                  S.current.appName,
                  style: ShadTheme.of(context).textTheme.h4,
                ),
              ],
            ),
          ),
          const ShadSeparator.horizontal(thickness: 1, margin: EdgeInsets.zero),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16, top: 16),
              children: [
                ListTile(
                  selected: true,
                  selectedColor: Colors.red,
                  leading: const Icon(Icons.bar_chart),
                  title: const Text('Statistics'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text('Calendar'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
