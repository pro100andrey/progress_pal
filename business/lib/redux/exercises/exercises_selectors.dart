import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../app_state.dart';
import '../my_exercises_view/actions/retrieve_my_exercises_action.dart';

/// Returns waiting value
bool selectExercisesIsWaiting(AppState state) =>
    state.wait.isWaitingForType<RetrieveMyExercisesAction>();

/// Returns [IMap<String, Exercise>] table
IMap<String, Exercise> selectExercisesTable(AppState state) =>
    state.exercises.table;

/// Returns [Exercise] value by id
Exercise selectExerciseById(AppState state, {required String id}) =>
    selectExercisesTable(state)[id]!;

List<String> selectMyExercisesPreviews(AppState state, {required String id}) {
  final exercise = selectExerciseById(state, id: id);

  return exercise.previewUrlsPath
      .map((e) => getPocketBase.baseURL + e)
      .toList(growable: false);
}
