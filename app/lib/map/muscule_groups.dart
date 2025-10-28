import 'package:ui/models/muscle_group_type.dart';

MuscleGroupType mapSlugToMuscleGroupType(String slug) {
  switch (slug) {
    case 'abs':
      return MuscleGroupType.abs;
    case 'back':
      return MuscleGroupType.back;
    case 'biceps':
      return MuscleGroupType.biceps;
    case 'cardio':
      return MuscleGroupType.cardio;
    case 'chest':
      return MuscleGroupType.chest;
    case 'forearms':
      return MuscleGroupType.forearms;
    case 'glutes':
      return MuscleGroupType.glutes;
    case 'shoulders':
      return MuscleGroupType.shoulders;
    case 'triceps':
      return MuscleGroupType.triceps;
    case 'upper_legs':
      return MuscleGroupType.upperLegs;
    case 'lower_legs':
      return MuscleGroupType.lowerLegs;
    default:
      return MuscleGroupType.other;
  }
}
