import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../exercises_selectors.dart';

class DeleteExerciseAction extends ReduxAction<AppState> {
  DeleteExerciseAction({required this.exerciseId});

  final String exerciseId;

  @override
  AppState reduce() {
    final table = selectExercisesTable(state);
    final updatedTable = table.remove(exerciseId);

    return state.copyWith.exercises(table: updatedTable);
  }
}
