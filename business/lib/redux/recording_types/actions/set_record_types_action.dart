import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';
import '../recording_types_selectors.dart';

class SetRecordTypesAction extends ReduxAction<AppState> {
  SetRecordTypesAction({required this.items});

  final IList<RecordingType> items;

  @override
  AppState reduce() {
    final byId = IMap<String, RecordingType>.fromValues(
      values: items,
      keyMapper: (v) => v.id,
    );

    final table = selectRecordingTypesTable(state);
    final updatedTable = table.addAll(byId);
    final view = byId.keys.toIList();

    return state.copyWith.recordingTypes(table: updatedTable, view: view);
  }
}
