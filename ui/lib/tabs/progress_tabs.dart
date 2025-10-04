import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: ShadTabs<ProgressTab>(
      gap: 0,
      value: vm.value,
      scrollable: true,
      onChanged: vm.onChangedSync,
      tabs: [
        ShadTab(
          value: ProgressTab.logs,
          child: Row(
            spacing: 8,
            children: [
              const Icon(LucideIcons.logs200),
              if (!iconsMode) Text(ProgressTab.logs.title),
            ],
          ),
        ),
        ShadTab(
          value: ProgressTab.bodyStats,
          child: Row(
            spacing: 8,
            children: [
              const Icon(LucideIcons.scale200),
              if (!iconsMode) Text(ProgressTab.bodyStats.title),
            ],
          ),
        ),
        ShadTab(
          value: ProgressTab.notes,
          child: Row(
            spacing: 8,
            children: [
              const Icon(LucideIcons.notebookPen200),
              if (!iconsMode) Text(ProgressTab.notes.title),
            ],
          ),
        ),
      ],
    ),
  );
}
