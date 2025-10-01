import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../app_state.dart';
import 'actions/retrieve_muscle_groups_action.dart';

/// Returns waiting value
bool selectMuscleGroupsIsWaiting(AppState state) =>
    state.wait.isWaitingForType<RetrieveMuscleGroupsAction>();

/// Returns [IMap<String, MuscleGroup>] table
IMap<String, MuscleGroup> selectMuscleGroupsTable(AppState state) =>
    state.muscleGroups.table;

/// Returns [IList<String>] view
IList<String> selectMuscleGroupsView(AppState state) => state.muscleGroups.view;

/// Returns [MuscleGroup] value by id
MuscleGroup selectMuscleGroupById(AppState state, {required String id}) =>
    selectMuscleGroupsTable(state)[id]!;

/// Returns all [MuscleGroup] values in view order
IList<MuscleGroup> selectMuscleGroupsByView(AppState state) {
  final table = selectMuscleGroupsTable(state);
  final view = selectMuscleGroupsView(state);

  return view.map((id) => table[id]!).toIList();
}

/// Returns [MuscleGroup] value by slug
MuscleGroup? selectMuscleGroupBySlug(AppState state, {required String slug}) {
  final table = selectMuscleGroupsTable(state);

  return table.values.firstWhereOrNull((mg) => mg.slug == slug);
}

// /// Returns the index of a [MuscleGroup] value by id
// int selectMuscleGroupIndexById(AppState state, {required String id}) =>
//     _selectMuscleGroupValuesCache(state.muscleGroups.view)(id);

// /// Caches the index of a [MuscleGroup] value by id
// final _selectMuscleGroupValuesCache =
//     cache1state_1param<int, IList<String>, String>(
//       (view) =>
//           (id) => view.indexOf(id),
//     );
