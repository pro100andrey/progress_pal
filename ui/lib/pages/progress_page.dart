import 'package:flutter/material.dart';

import '../models/value_changed.dart';
import '../selectors/date_tiime_line_selector.dart';
import '../tabs/progress_tabs.dart';

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
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        DateTimeLineSelector(vm: dateSelector),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressTabs(vm: tab, iconsMode: constraints.maxWidth < 450),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(child: child),
      ],
    ),
  );
}
