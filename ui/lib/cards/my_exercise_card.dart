import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/equipment_type.dart';
import '../popovers/my_exercise_actions.dart';

class MyExerciseCardVm extends Equatable {
  const MyExerciseCardVm({
    required this.title,
    required this.instructions,
    required this.equipmentType,
    required this.muscleGroups,
    required this.actions,
  });

  final String title;
  final String? instructions;
  final EquipmentType equipmentType;
  final List<String> muscleGroups;
  final MyExerciseActionsVm actions;

  @override
  List<Object?> get props => [title, instructions, muscleGroups, actions];
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

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        vm.equipmentType.image.image(width: 50, height: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(vm.title, style: ShadTheme.of(context).textTheme.h3),
            Row(
              children: [
                ...vm.muscleGroups.map(
                  (mg) => ShadBadge.outline(child: Text(mg)),
                ),
              ],
            ),
            if (vm.instructions != null && vm.instructions!.isNotEmpty)
              Text(
                vm.instructions!.trim().replaceAll('\n', ' '),
                maxLines: 4,
              ),
          ],
        ),
      ],
    ),
  );
}
