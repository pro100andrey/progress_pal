import 'package:flutter/material.dart';

import '../placeholders/no_workouts_placeholder.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Center(
          child: NoWorkoutsPlaceholder(),
        ),
      ],
    ),
  );
}
