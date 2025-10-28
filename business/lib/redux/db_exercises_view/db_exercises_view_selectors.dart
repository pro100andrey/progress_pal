import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../app_state.dart';

/// Returns [IList<String>] of exercise IDs
IList<String> selectDbExercisesView(AppState state) =>
    state.dbExercisesView.view;
