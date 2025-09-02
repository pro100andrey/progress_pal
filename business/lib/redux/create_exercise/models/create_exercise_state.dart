import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_exercise_state.freezed.dart';

@freezed
abstract class CreateExerciseState with _$CreateExerciseState {
  const factory CreateExerciseState({
    String? title,
    String? muscleGroupId,
    String? equipmentId,
    String? recordingTypeId,
    String? instructions,
  }) = _CreateExerciseState;
}
