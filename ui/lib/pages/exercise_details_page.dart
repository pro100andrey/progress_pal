import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(S.current.title)),
    body: const Stack(
      children: [Center(child: Text('ExercisesDetailsPage Coming soon...'))],
    ),
  );
}
