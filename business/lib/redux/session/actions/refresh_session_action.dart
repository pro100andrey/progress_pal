import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class RefreshSessionAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // Refresh the authentication state and call AsyncAuthStore.save internally.
    await getPB.collection('users').authRefresh();

    return null;
  }
}
