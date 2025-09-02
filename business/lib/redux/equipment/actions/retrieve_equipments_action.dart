import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import 'set_equipments_action.dart';

class RetrieveEquipmentsAction extends ReduxAction<AppState> with WaitingFor {
  @override
  Future<AppState?> reduce() async {
    final collection = EquipmentsCollection(getPocketBase);
    final items = await collection.getFullList();

    dispatchSync(SetEquipmentsAction(items: items.lock), notify: false);
    return null;
  }
}
