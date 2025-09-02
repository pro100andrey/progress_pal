import 'package:flutter/material.dart';

import '../cards/my_exercise_card.dart';
import '../placeholders/no_my_exercises.dart';
import '../sizer/sizer.dart';

class MyExercises extends StatelessWidget {
  const MyExercises({
    required this.isWaiting,
    required this.exercises,
    super.key,
  });

  final bool isWaiting;
  final List<MyExerciseCardVm> exercises;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) {
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

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: switch (Device.width) {
            < 768 => 1,
            < 1200 => 2,
            _ => 3,
          },
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: exercises.length,
        itemBuilder: (context, index) => MyExerciseCard(
          vm: exercises[index],
        ),
      );
    },
  );
}
