import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../app_state.dart';

/// Returns [IMap<String, RecordingTypes>] table
IMap<String, RecordingType> selectRecordingTypesTable(AppState state) =>
    state.recordingTypes.table;

/// Return [IList<String>] view
IList<String> selectRecordingTypesView(AppState state) =>
    state.recordingTypes.view;

/// Returns [RecordingType] value by id
RecordingType selectRecordingTypesById(AppState state, {required String id}) =>
    selectRecordingTypesTable(state)[id]!;

/// Returns all [RecordingType] values in view order
IList<RecordingType> selectRecordingTypes(AppState state) {
  final table = selectRecordingTypesTable(state);
  final view = selectRecordingTypesView(state);

  return view.map((id) => table[id]!).toIList();
}

/// Returns [RecordingType] value by slug
RecordingType? selectRecordingTypeBySlug(
  AppState state, {
  required String slug,
}) {
  final table = selectRecordingTypesTable(state);

  return table.values.firstWhereOrNull((rt) => rt.slug == slug);
}

/// Returns the index of a [RecordingType] value by id
int selectRecordingTypeIndexById(AppState state, {required String id}) =>
    selectRecordingTypesView(state).indexOf(id);
