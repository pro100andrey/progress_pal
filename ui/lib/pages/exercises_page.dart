import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../button/filter_button.dart';
import '../models/value_changed.dart';
import '../side_bar/side_bar.dart';
import '../tabs/exercises_tabs.dart';
import '../ui.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({
    required this.child,
    required this.tabs,
    super.key,
  });

  final Widget child;
  final ValueChangedVm<ExerciseTab> tabs;

  @override
  Widget build(BuildContext context) {
    final isPhone = UI.isPhone(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              children: [
                ExercisesTabs(vm: tabs, iconsMode: isPhone),
                if (tabs.value == ExerciseTab.database)
                  FilterButton(
                    isIconsMode: isPhone,
                    onPressed: () => showSideBar(
                      context,
                      child: SideBar(
                        title: Text(S.current.exerciseFilter),
                        content: const Column(
                          spacing: 16,
                          children: [
                            TextField(),
                            TextField(),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
