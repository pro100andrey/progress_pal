import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import 'set_record_types_action.dart';

class RetrieveRecordingTypesAction extends ReduxAction<AppState>
    with BaseWrapError {
  @override
  Future<AppState?> reduce() async {
    final items = await getPB.x.recordingTypes.getFullList();



    dispatchSync(SetRecordTypesAction(items: items.lock), notify: false);

    return null;
  }
}
