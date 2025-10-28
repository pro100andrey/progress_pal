import 'package:ui/models/equipment_type.dart';

EquipmentType mapSlugToEquipmentType(String slug) {
  switch (slug) {
    case 'body_weight':
      return EquipmentType.bodyWeight;
    case 'bands':
      return EquipmentType.bands;
    case 'barbell':
      return EquipmentType.barbell;
    case 'bench':
      return EquipmentType.bench;
    case 'dumbbell':
      return EquipmentType.dumbbell;
    case 'exercise_ball':
      return EquipmentType.exerciseBall;
    case 'ez_curl_bar':
      return EquipmentType.ezCurlBar;
    case 'foam_roll':
      return EquipmentType.foamRoll;
    case 'kettlebell':
      return EquipmentType.kettlebell;
    case 'machine_cardio':
      return EquipmentType.machineCardio;
    case 'machine_strength':
      return EquipmentType.machineStrength;
    case 'pullup_bar':
      return EquipmentType.pullupBar;
    case 'weight_plate':
      return EquipmentType.weightPlate;
    default:
      return EquipmentType.other;
  }
}
