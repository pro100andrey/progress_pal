import 'dart:async';

import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import 'save_session_action.dart';

class CleanSessionAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    getPocketBase.authStore.clear();

    unawaited(dispatchAndWait(SaveSessionAction(pbAuth: null)));

    return AppState.initial();
  }
}
