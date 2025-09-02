import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';
import '../equipments_selectors.dart';

class SetEquipmentsAction extends ReduxAction<AppState> {
  SetEquipmentsAction({required this.items});

  final IList<Equipment> items;

  @override
  AppState reduce() {
    final byId = IMap<String, Equipment>.fromValues(
      values: items,
      keyMapper: (v) => v.id,
    );

    final table = selectEquipmentsTable(state);
    final updatedTable = table.addAll(byId);
    final view = byId.keys.toIList();

    return state.copyWith.equipments(table: updatedTable, view: view);
  }
}
