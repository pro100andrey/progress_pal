import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';
import '../models/image_source.dart';

/// Returns exercise title
IMap<String, String?>? selectCreateDbExerciseTitle(AppState state) =>
    state.createDbExercise.title;

/// Returns selected muscle group ids
IList<String> selectCreateDbExerciseMuscleGroupIds(AppState state) =>
    state.createDbExercise.muscleGroupIds;

/// Returns selected equipment id
String? selectCreateDbExerciseEquipmentId(AppState state) =>
    state.createDbExercise.equipmentId;

/// Returns selected recording type id
String? selectCreateDbExerciseRecordingTypeId(AppState state) =>
    state.createDbExercise.recordingTypeId;

/// Returns exercise instructions
IMap<String, Delta?>? selectCreateDbExerciseInstructions(
  AppState state,
) => state.createDbExercise.instructions;

/// Returns exercise images
IList<MemoryImageSource> selectCreateDbExerciseImages(AppState state) =>
    state.createDbExercise.images;
