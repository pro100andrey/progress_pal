import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';
import '../muscle_groups_selectors.dart';

class SetMuscleGroupsAction extends ReduxAction<AppState> {
  SetMuscleGroupsAction({required this.items});

  final IList<MuscleGroup> items;

  @override
  AppState reduce() {
    final byId = IMap<String, MuscleGroup>.fromValues(
      values: items,
      keyMapper: (v) => v.id,
    );

    final table = selectMuscleGroupsTable(state);
    final updatedTable = table.addAll(byId);
    final view = byId.keys.toIList();

    return state.copyWith.muscleGroups(table: updatedTable, view: view);
  }
}
