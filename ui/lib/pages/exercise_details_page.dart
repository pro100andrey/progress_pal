import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../image/image_preview.dart';
import '../image/model.dart';

class ExerciseDetailsPage extends StatelessWidget {
  const ExerciseDetailsPage({
    required this.title,
    required this.preview,
    required this.instructions,
    required this.muscleGroups,
    super.key,
  });

  final String title;
  final ImageVm preview;
  final String instructions;
  final List<String> muscleGroups;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 400,
              child: ImagePreview(
                source: preview,
                cacheSize: const Size.square(1024),
              ),
            ),
          ),
          Text(
            instructions,
            style: ShadTheme.of(context).textTheme.p,
          ),
        ],
      ),
    ),
  );
}
