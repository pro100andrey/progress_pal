import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../current_profile/actions/unsubscribe_current_profile_action.dart';
import 'save_session_action.dart';

class CleanSessionAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    getPB.authStore.clear();
    dispatchAll([
      // Unsubscribe from profile updates
      UnsubscribeCurrentProfileAction(),
      // Clear saved session
      SaveSessionAction(pbAuth: null),
    ], notify: false);

    return AppState.initial().copyWith(
      theme: state.theme,
    );
  }
}
