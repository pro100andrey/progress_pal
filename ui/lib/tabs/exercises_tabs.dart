import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';

enum ExerciseTab {
  my,
  database;

  String get title {
    switch (this) {
      case ExerciseTab.my:
        return S.current.my;
      case ExerciseTab.database:
        return S.current.database;
    }
  }

  IconData get icon {
    switch (this) {
      case ExerciseTab.my:
        return LucideIcons.user;
      case ExerciseTab.database:
        return LucideIcons.database;
    }
  }
}

class ExercisesTabs extends StatelessWidget {
  const ExercisesTabs({
    required this.vm,
    required this.iconsMode,
    super.key,
  });

  final ValueChangedVm<ExerciseTab> vm;
  final bool iconsMode;

  @override
  Widget build(BuildContext context) => SegmentedButton<ExerciseTab>(
    showSelectedIcon: false,
    segments: ExerciseTab.values
        .map(
          (tab) => ButtonSegment<ExerciseTab>(
            value: tab,
            label: !iconsMode ? Text(tab.title) : null,
            icon: Icon(tab.icon),
          ),
        )
        .toList(growable: false),
    selected: {vm.value},
    selectedIcon: Icon(vm.value.icon),
    onSelectionChanged: (newSelection) {
      final selectedTab = newSelection.first;
      vm.onChangedSync(selectedTab);
    },
  );
}
