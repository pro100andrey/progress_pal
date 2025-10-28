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
        return Assets.muscleGroups.frontOther;
    }
  }
}
