import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../app_state.dart';

/// Returns [IMap<String, Equipment>] table
IMap<String, Equipment> selectEquipmentsTable(AppState state) =>
    state.equipments.table;

/// Returns [IList<String>] view
IList<String> selectEquipmentsView(AppState state) => state.equipments.view;

/// Returns [Equipment] value by id
Equipment selectEquipmentById(AppState state, {required String id}) =>
    selectEquipmentsTable(state)[id]!;

/// Returns all [Equipment] values in view order
IList<Equipment> selectEquipments(AppState state) {
  final table = selectEquipmentsTable(state);
  final view = selectEquipmentsView(state);

  return view.map((id) => table[id]!).toIList();
}

/// Returns [Equipment] value by slug
Equipment? selectEquipmentBySlug(AppState state, {required String slug}) {
  final table = selectEquipmentsTable(state);

  return table.values.firstWhereOrNull((eq) => eq.slug == slug);
}

/// Returns the index of a [Equipment] value by id
int selectEquipmentIndexById(AppState state, {required String id}) =>
    selectEquipmentsView(state).indexOf(id);
