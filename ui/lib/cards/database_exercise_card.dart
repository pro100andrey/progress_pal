import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../image/model.dart';

class DatabaseExerciseCardVm extends Equatable {
  const DatabaseExerciseCardVm({
    required this.title,
    required this.preview,
    required this.instructions,
  });

  final String title;
  final ImageVm preview;
  final String instructions;

  @override
  List<Object?> get props => [title, preview, instructions];
}

class DatabaseExerciseCard extends StatelessWidget {
  const DatabaseExerciseCard({
    required this.vm,
    super.key,
  });

  final DatabaseExerciseCardVm vm;

  @override
  Widget build(BuildContext context) => ShadCard(
    padding: const EdgeInsets.all(16),
    title: Text(vm.title),
    description: Text(
      vm.instructions.trim().replaceAll('\n', ' '),
      maxLines: 4,
    ),
  );
}
