import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';
import '../exercises_selectors.dart';

class AddExercisesAction extends ReduxAction<AppState> {
  AddExercisesAction({required this.items});

  final IList<Exercise> items;

  @override
  AppState reduce() {
    final byId = IMap<String, Exercise>.fromValues(
      values: items,
      keyMapper: (v) => v.id,
    );

    final table = selectExercisesTable(state);
    final updatedTable = table.addAll(byId);

    return state.copyWith.exercises(table: updatedTable);
  }
}
