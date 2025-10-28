import '../generated/assets.gen.dart';

enum EquipmentType {
  bodyWeight,
  bands,
  barbell,
  bench,
  dumbbell,
  exerciseBall,
  ezCurlBar,
  foamRoll,
  kettlebell,
  machineCardio,
  machineStrength,
  pullupBar,
  weightPlate,
  other;

  AssetGenImage get image {
    switch (this) {
      case EquipmentType.bodyWeight:
        return Assets.equipments.bodyWeight256;
      case EquipmentType.bands:
        return Assets.equipments.bands256;
      case EquipmentType.barbell:
        return Assets.equipments.barbell256;
      case EquipmentType.bench:
        return Assets.equipments.bench256;
      case EquipmentType.dumbbell:
        return Assets.equipments.dumbbell256;
      case EquipmentType.exerciseBall:
        return Assets.equipments.exerciseBall256;
      case EquipmentType.ezCurlBar:
        return Assets.equipments.ezCurlBar256;
      case EquipmentType.foamRoll:
        return Assets.equipments.foamRoll256;
      case EquipmentType.kettlebell:
        return Assets.equipments.kettlebell256;
      case EquipmentType.machineCardio:
        return Assets.equipments.cardioMachine256;
      case EquipmentType.machineStrength:
        return Assets.equipments.strengthMachine256;
      case EquipmentType.pullupBar:
        return Assets.equipments.pullUpBar256;
      case EquipmentType.weightPlate:
        return Assets.equipments.weightPlate256;
      case EquipmentType.other:
        return Assets.equipments.custom256;
    }
  }
}
