import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../items/muscle_group_item.dart';
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
  final List<MuscleGroupItemVm> muscleGroups;
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
  Widget build(BuildContext context) => Card(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        // vm.equipmentType.image.image(width: 50, height: 50),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(vm.title),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...vm.muscleGroups.map(
                    (e) => MuscleGroupItem(vm: e),
                  ),
                ],
              ),
              if (vm.instructions != null && vm.instructions!.isNotEmpty)
                Text(
                  vm.instructions!.trim().replaceAll('\n', ' '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
