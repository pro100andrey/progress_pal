import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../image/image_preview.dart';
import '../image/model.dart';
import '../rich_text/rich_text_preview.dart';

class DatabaseExerciseCardVm extends Equatable {
  const DatabaseExerciseCardVm({
    required this.title,
    required this.preview,
    required this.instructions,
    required this.muscleGroups,
    required this.onPressed,
  });

  final String title;
  final ImageVm preview;
  final Delta instructions;
  final List<String> muscleGroups;
  final VoidCallback onPressed;

  @override
  List<Object?> get props => [title, preview, instructions, muscleGroups];
}

class DatabaseExerciseCard extends StatelessWidget {
  const DatabaseExerciseCard({
    required this.vm,
    super.key,
  });

  final DatabaseExerciseCardVm vm;

  @override
  Widget build(BuildContext context) => Card(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: vm.onPressed,
        highlightColor: Colors.transparent,
        // splashColor: ShadTheme.of(context).colorScheme.primary.withAlpha(50),
        hoverDuration: const Duration(milliseconds: 300),
        hoverColor: Colors.blueGrey.withAlpha(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              Expanded(
                child: ImagePreview(
                  source: vm.preview,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Text(vm.title),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  ...vm.muscleGroups.map(
                    (mg) => Badge(child: Text(mg)),
                  ),
                ],
              ),
              RichTextPlainPreview(
                delta: vm.instructions,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
