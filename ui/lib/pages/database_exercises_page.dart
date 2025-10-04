import 'dart:math';

import 'package:flutter/material.dart';

import '../cards/database_exercise_card.dart';

class DatabaseExercisesPage extends StatelessWidget {
  const DatabaseExercisesPage({
    required this.isWaiting,
    required this.exercises,
    super.key,
  });

  final bool isWaiting;
  final List<DatabaseExerciseCardVm> exercises;

  @override
  Widget build(BuildContext context) => Scaffold(
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
            bottom: 64, // FAB
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
}
