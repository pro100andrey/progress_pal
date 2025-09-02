import '../app_state.dart';
import 'actions/create_exercise_action.dart';

/// Returns true if the create exercise action is waiting
bool selectCreateExerciseIsWaiting(AppState state) =>
    state.wait.isWaitingForType<CreateExerciseAction>();

/// Returns title
String? selectCreateExerciseTitle(AppState state) => state.createExercise.title;

String? selectCreateExerciseMuscleGroupId(AppState state) =>
    state.createExercise.muscleGroupId;

String? selectCreateExerciseEquipmentId(AppState state) =>
    state.createExercise.equipmentId;

String? selectCreateExerciseRecordingTypeId(AppState state) =>
    state.createExercise.recordingTypeId;

String? selectCreateExerciseInstructions(AppState state) =>
    state.createExercise.instructions;
