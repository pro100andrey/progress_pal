import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';

/// Returns exercise title
String? selectCreateMyExerciseTitle(AppState state) =>
    state.createMyExercise.title;

/// Returns selected muscle group ids
IList<String> selectCreateMyExerciseMuscleGroupIds(AppState state) =>
    state.createMyExercise.muscleGroupIds;

/// Returns selected equipment id
String? selectCreateMyExerciseEquipmentId(AppState state) =>
    state.createMyExercise.equipmentId;

/// Returns selected recording type id
String? selectCreateMyExerciseRecordingTypeId(AppState state) =>
    state.createMyExercise.recordingTypeId;

/// Returns exercise instructions
String? selectCreateMyExerciseInstructions(AppState state) =>
    state.createMyExercise.instructions;
