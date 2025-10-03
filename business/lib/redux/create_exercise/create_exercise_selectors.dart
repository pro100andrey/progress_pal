import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';
import 'actions/create_exercise_action.dart';

/// Returns true if the create exercise action is waiting
bool selectCreateExerciseIsWaiting(AppState state) =>
    state.wait.isWaitingForType<CreateExerciseAction>();

/// Returns exercise title
String? selectCreateExerciseTitle(AppState state) => state.createExercise.title;

/// Returns selected muscle group ids
IList<String> selectCreateExerciseMuscleGroupIds(AppState state) =>
    state.createExercise.muscleGroupIds;

/// Returns selected equipment id
String? selectCreateExerciseEquipmentId(AppState state) =>
    state.createExercise.equipmentId;

/// Returns selected recording type id
String? selectCreateExerciseRecordingTypeId(AppState state) =>
    state.createExercise.recordingTypeId;

/// Returns exercise instructions
String? selectCreateExerciseInstructions(AppState state) =>
    state.createExercise.instructions;
