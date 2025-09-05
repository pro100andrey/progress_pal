import 'package:flutter/material.dart';

import '../selectors/date_tiime_line_selector.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({required this.dateSelector, super.key});

  final DateTimeLineSelectorVm dateSelector;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        DateTimeLineSelector(vm: dateSelector),
      ],
    ),
  );
}
