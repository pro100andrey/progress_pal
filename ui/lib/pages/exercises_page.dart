import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../tabs/exercises_tabs.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({
    required this.databaseExercisesContent,
    required this.myExercisesContent,
    required this.createExerciseDialog,
    super.key,
  });

  final Widget databaseExercisesContent;
  final Widget myExercisesContent;
  final Widget createExerciseDialog;


  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.createExercise,
      onPressed: () => _onTapAddExercise(context),
      child: const Icon(LucideIcons.plus),
    ),
    body: ExercisesTabs(
      databaseExercisesContent: databaseExercisesContent,
      myExercisesContent: myExercisesContent,
    ),
  );

  Future<void> _onTapAddExercise(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => createExerciseDialog,
    );
  }
}
