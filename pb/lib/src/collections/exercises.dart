import '../../models.dart';
import 'base_pb.dart';

class ExercisesCollection extends PBCollection<Exercise>
    with
        PBListMixin,
        PBCreateMixin<Exercise, ExerciseBody>,
        PBUpdateMixin<Exercise, ExerciseBody>,
        PBDeleteMixin<Exercise, ExerciseBody> {
  const ExercisesCollection(super.pocketBase);

  @override
  String get collectionName => 'exercises';
}

class ExerciseBody extends PBToJson {
  const ExerciseBody({
    this.title,
    this.instructions,
    this.createdById,
    this.muscleGroupId,
    this.equipmentId,
    this.recordingTypeId,
  });

  final LanguageString? title;
  final LanguageString? instructions;
  final String? createdById;
  final String? muscleGroupId;
  final String? equipmentId;
  final String? recordingTypeId;

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'instructions': instructions,
    'created_by': createdById,
    'muscle_group': muscleGroupId,
    'equipment': equipmentId,
    'recording_type': recordingTypeId,
  };
}
