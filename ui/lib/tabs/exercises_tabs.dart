import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
}

class ExercisesTabs extends StatelessWidget {
  const ExercisesTabs({
    required this.vm,
    super.key,
  });

  final ValueChangedVm<ExerciseTab> vm;

  @override
  Widget build(BuildContext context) => ShadTabs<ExerciseTab>(
    gap: 0,
    value: vm.value,
    scrollable: true,
    padding: EdgeInsets.zero,
    onChanged: vm.onChangedSync,
    tabs: [
      ShadTab(
        value: ExerciseTab.my,
        child: Text(S.current.my),
      ),
      ShadTab(
        value: ExerciseTab.database,
        child: Text(S.current.database),
      ),
    ],
  );
}
