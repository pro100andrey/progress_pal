import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';
import 'actions/retrieve_database_exercises_action.dart';

/// Returns true if currently waiting for [RetrieveDatabaseExercisesAction].
bool selectDatabaseExercisesIsWaiting(AppState state) =>
    state.wait.isWaitingForType<RetrieveDatabaseExercisesAction>();

/// Returns [IList<String>] of exercise IDs
IList<String> selectDatabaseExercisesView(AppState state) =>
    state.databaseExercisesView.view;
