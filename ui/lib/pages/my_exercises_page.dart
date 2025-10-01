import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../cards/my_exercise_card.dart';
import '../placeholders/no_my_exercises.dart';

class MyExercisesPage extends StatelessWidget {
  const MyExercisesPage({
    required this.isWaiting,
    required this.exercises,
    required this.createExerciseDialog,
    super.key,
  });

  final bool isWaiting;
  final List<MyExerciseCardVm> exercises;
  final Widget createExerciseDialog;

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.createExercise,
      onPressed: () => _onTapAddExercise(context),
      child: const Icon(LucideIcons.plus),
    ),
    body: LayoutBuilder(
      builder: (context, constraints) {
        if (isWaiting && exercises.isEmpty) {
          return const SizedBox.expand();
        }

        if (exercises.isEmpty) {
          return Center(
            child: NoMyExercisesPlaceholder(),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,

          itemCount: exercises.length,
          itemBuilder: (context, index) => MyExerciseCard(vm: exercises[index]),
        );
      },
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
