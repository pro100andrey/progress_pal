import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../popovers/my_exercise_actions.dart';

class MyExerciseCardVm extends Equatable {
  const MyExerciseCardVm({
    required this.title,
    required this.instructions,
    required this.actions,
  });

  final String title;
  final String? instructions;
  final MyExerciseActionsVm actions;

  @override
  List<Object?> get props => [title, instructions, actions];
}

class MyExerciseCard extends StatelessWidget {
  const MyExerciseCard({
    required this.vm,
    super.key,
  });

  final MyExerciseCardVm vm;

  @override
  Widget build(BuildContext context) => ShadCard(
    trailing: MyExerciseActions(vm: vm.actions),
    padding: const EdgeInsets.all(16),
    title: Text(vm.title),
    description: vm.instructions != null ? Text(vm.instructions!) : null,
  );
}
