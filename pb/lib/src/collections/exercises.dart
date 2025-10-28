import '../../models.dart';
import 'base_pb.dart';

class ExercisesCollection extends PBCollection
    with
        PBListMixin<Exercise>,
        PBCreateMixin<Exercise, CreateExerciseBody>,
        PBDeleteMixin {
  const ExercisesCollection(super.pocketBase);

  @override
  String get collectionName => 'exercises';
}

class CreateExerciseBody extends PBToJson {
  const CreateExerciseBody({
    required this.createdById,
    required this.title,
    required this.muscleGroupIds,
    required this.equipmentId,
    required this.recordingTypeId,
    this.instructions,
    this.isSystem,
  });

  final String createdById;
  final LanguageString title;
  final List<String> muscleGroupIds;
  final String equipmentId;
  final String recordingTypeId;
  final LanguageString? instructions;
  final bool? isSystem;

  @override
  Map<String, dynamic> toJson() => {
    'created_by': createdById,
    'title': title,
    'instructions': ?instructions,
    'muscle_groups': muscleGroupIds,
    'equipment': equipmentId,
    'recording_type': recordingTypeId,
    'is_system': ?isSystem,
  };
}
