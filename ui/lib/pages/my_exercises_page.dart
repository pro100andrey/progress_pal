import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                // Center the content horizontally
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ), // Set your desired max width
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemCount: exercises.length,
                    itemBuilder: (context, index) =>
                        MyExerciseCard(vm: exercises[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                  ),
                ),
              ),
            ),
          ],
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
