import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../app_state.dart';

/// Returns [IMap<String, MuscleGroup>] table
IMap<String, MuscleGroup> selectMuscleGroupsTable(AppState state) =>
    state.muscleGroups.table;

/// Returns [IList<String>] view
IList<String> selectMuscleGroupsView(AppState state) => state.muscleGroups.view;

/// Returns [MuscleGroup] value by id
MuscleGroup? selectMuscleGroupById(AppState state, {required String id}) =>
    selectMuscleGroupsTable(state)[id];

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
