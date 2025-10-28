import 'dart:math';

import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../cards/database_exercise_card.dart';

class DbExercisesPage extends StatelessWidget {
  const DbExercisesPage({
    required this.isWaiting,
    required this.exercises,
    required this.createExerciseDialog,
    super.key,
  });

  final bool isWaiting;
  final Widget? createExerciseDialog;
  final List<DatabaseExerciseCardVm> exercises;

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: createExerciseDialog != null
        ? FloatingActionButton.small(
            tooltip: S.current.createExercise,
            onPressed: () => _onTapAddExercise(context),
            child: const Icon(LucideIcons.plus),
          )
        : null,
    body: LayoutBuilder(
      builder: (context, constraints) {
        if (isWaiting && exercises.isEmpty) {
          return const SizedBox.expand();
        }

        final columnWidth = constraints.maxWidth / 300;
        final columnCount = columnWidth > 1 ? columnWidth.floor() : 1;

        return GridView.builder(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 64,
          ),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: max(columnCount, 1),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: exercises.length,
          itemBuilder: (context, index) => DatabaseExerciseCard(
            vm: exercises[index],
          ),
        );
      },
    ),
  );

  Future<void> _onTapAddExercise(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => createExerciseDialog!,
    );
  }
}
