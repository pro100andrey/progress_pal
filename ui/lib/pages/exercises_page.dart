import 'package:flutter/material.dart';

import '../models/value_changed.dart';
import '../tabs/exercises_tabs.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({
    required this.child,
    required this.tabs,
    super.key,
  });

  final Widget child;
  final ValueChangedVm<ExerciseTab> tabs;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ExercisesTabs(
            vm: tabs,
          ),
        ),
        Expanded(child: child),
      ],
    ),
  );
}
