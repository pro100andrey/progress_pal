import 'dart:math';

import 'package:flutter/material.dart';

import '../cards/my_exercise_card.dart';
import '../placeholders/no_my_exercises.dart';

class MyExercises extends StatelessWidget {
  const MyExercises({
    required this.isWaiting,
    required this.exercises,
    super.key,
  });

  final bool isWaiting;
  final List<MyExerciseCardVm> exercises;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (isWaiting && exercises.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (exercises.isEmpty) {
        return Center(
          child: NoMyExercisesPlaceholder(),
        );
      }

      final columnWidth = constraints.maxWidth / 300;
      final columnCount = columnWidth > 1 ? columnWidth.floor() : 1;

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: max(columnCount, 1),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: exercises.length,
        itemBuilder: (context, index) => MyExerciseCard(vm: exercises[index]),
      );
    },
  );
}
