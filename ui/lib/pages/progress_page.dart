import 'package:flutter/material.dart';

import '../models/value_changed.dart';
import '../selectors/date_tiime_line_selector.dart';
import '../tabs/progress_tabs.dart';
import '../ui.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({
    required this.dateSelector,
    required this.tab,
    required this.child,
    super.key,
  });

  final DateTimeLineSelectorVm dateSelector;
  final ValueChangedVm<ProgressTab> tab;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isPhone = UI.isPhone(context);

    return Scaffold(
      body: Column(
        children: [
          DateTimeLineSelector(vm: dateSelector),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressTabs(vm: tab, iconsMode: isPhone),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}
