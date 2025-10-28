import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';

enum ProgressTab {
  logs,
  bodyStats,
  notes;

  String get title {
    switch (this) {
      case ProgressTab.logs:
        return S.current.logs;
      case ProgressTab.bodyStats:
        return S.current.bodyStats;
      case ProgressTab.notes:
        return S.current.notes;
    }
  }

  IconData get icon {
    switch (this) {
      case ProgressTab.logs:
        return LucideIcons.logs;
      case ProgressTab.bodyStats:
        return LucideIcons.scale;
      case ProgressTab.notes:
        return LucideIcons.notebookPen;
    }
  }
}

class ProgressTabs extends StatelessWidget {
  const ProgressTabs({
    required this.vm,
    required this.iconsMode,
    super.key,
  });

  final ValueChangedVm<ProgressTab> vm;
  final bool iconsMode;

  @override
  Widget build(BuildContext context) => SegmentedButton<ProgressTab>(
    showSelectedIcon: false,
    segments: ProgressTab.values
        .map(
          (tab) => ButtonSegment<ProgressTab>(
            value: tab,
            label: !iconsMode ? Text(tab.title) : null,
            icon: Icon(tab.icon),
          ),
        )
        .toList(growable: false),
    selected: {vm.value},
    onSelectionChanged: (newSelection) {
      final selectedTab = newSelection.first;
      vm.onChangedSync(selectedTab);
    },
  );
}
