import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum ExerciseType {
  my,
  database;

  String get title {
    switch (this) {
      case ExerciseType.my:
        return S.current.my;
      case ExerciseType.database:
        return S.current.database;
    }
  }
}

class ExercisesTabs extends StatelessWidget {
  const ExercisesTabs({
    required this.myExercisesContent,
    required this.databaseExercisesContent,

    super.key,
  });

  final Widget myExercisesContent;
  final Widget databaseExercisesContent;

  @override
  Widget build(BuildContext context) => ShadTabs<ExerciseType>(
    value: ExerciseType.my,
    expandContent: true,
    scrollable: true,
    onChanged: (value) => debugPrint('Selected exercise type: $value'),
    tabs: [
      ShadTab(
        value: ExerciseType.my,
        content: myExercisesContent,
        child: Text(S.current.my),
      ),
      ShadTab(
        value: ExerciseType.database,
        content: databaseExercisesContent,
        child: Text(S.current.database),
      ),
    ],
  );
}
