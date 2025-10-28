import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';
import 'actions/delete_my_exercise_action.dart';
import 'actions/retrieve_my_exercises_action.dart';

/// Returns true if currently waiting for [RetrieveMyExercisesAction].
bool selectMyExercisesIsDeleting(
  AppState state, {
  required String exerciseId,
}) {
  final result = state.wait.isWaiting(
    DeleteMyExerciseAction.kFlag,
    ref: exerciseId,
  );

  return result;
}

/// Returns [IList<String>] of exercise IDs
IList<String> selectMyExercisesView(AppState state) =>
    state.myExercisesView.view;
