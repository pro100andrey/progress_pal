import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../app_state.dart';
import '../___state_name____selectors.dart';

class Add___StateName___Action extends ReduxAction<AppState> {
  Add___StateName___Action({required this.items});

  final IList<Object> items;

  @override
  AppState reduce() {
    final byId = IMap<String, Object>.fromValues(
      values: items,
      keyMapper: (v) => v.id,
    );

    final table = select___StateName___Table(state);
    final updatedTable = table.addAll(byId);
    final view = byId.keys.toIList();

    return state.copyWith.___stateName___(table: updatedTable, view: view);
  }
}
