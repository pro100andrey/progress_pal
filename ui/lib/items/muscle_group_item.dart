import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../generated/assets.gen.dart';

enum MuscleGroupType {
  abs,
  back,
  biceps,
  cardio,
  chest,
  forearms,
  glutes,
  shoulders,
  triceps,
  upperLegs,
  lowerLegs,
  other;

  SvgGenImage get image {
    switch (this) {
      case MuscleGroupType.abs:
        return Assets.muscleGroups.frontAbs;
      case MuscleGroupType.back:
        return Assets.muscleGroups.backBack;
      case MuscleGroupType.biceps:
        return Assets.muscleGroups.frontBiceps;
      case MuscleGroupType.cardio:
        return Assets.muscleGroups.frontCardio;
      case MuscleGroupType.chest:
        return Assets.muscleGroups.frontChest;
      case MuscleGroupType.forearms:
        return Assets.muscleGroups.frontForearms;
      case MuscleGroupType.glutes:
        return Assets.muscleGroups.backGlutes;
      case MuscleGroupType.shoulders:
        return Assets.muscleGroups.frontShoulders;
      case MuscleGroupType.triceps:
        return Assets.muscleGroups.backTriceps;
      case MuscleGroupType.upperLegs:
        return Assets.muscleGroups.frontUpperLegs;
      case MuscleGroupType.lowerLegs:
        return Assets.muscleGroups.frontLowerLegs;
      case MuscleGroupType.other:
        throw UnimplementedError();
    }
  }
}

class MuscleGroupItemVm extends Equatable {
  const MuscleGroupItemVm({
    required this.name,
    required this.type,
    required this.onPressed,
  });

  final String name;
  final MuscleGroupType type;
  final VoidCallback? onPressed;

  @override
  List<Object?> get props => [name, type, onPressed != null];
}

class MuscleGroupItem extends StatelessWidget {
  const MuscleGroupItem({required this.vm, super.key});

  final MuscleGroupItemVm vm;

  @override
  Widget build(BuildContext context) => ShadCard(
    padding: EdgeInsets.zero,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        vm.type.image.svg(width: 100, height: 100),
        Padding(
          padding: const EdgeInsets.all(2),
          child: Text(vm.name),
        ),
      ],
    ),
  );
}
