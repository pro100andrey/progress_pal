import 'package:async_redux/async_redux.dart';
import 'package:pb/models.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';
import '../../current_profile/actions/set_current_profile_action.dart';
import '../session_selectors.dart';

class SaveSessionAction extends ReduxAction<AppState> {
  SaveSessionAction({required this.pbAuth});

  final String? pbAuth;

  @override
  Future<AppState?> reduce() async {
    final currentPBAuth = selectSessionPBAuth(state);

    if (currentPBAuth == pbAuth) {
      return null;
    }

    pbAuth != null
        ? await getSettingsStorage.setPBAuth(pbAuth)
        : await getSettingsStorage.deletePBAuth();

    final currentUser = getPB.authStore.record;

    dispatchSync(
      SetCurrentProfileAction(
        user: currentUser != null ? User(currentUser) : null,
      ),
      notify: false,
    );

    return state.copyWith.session(pbAuth: pbAuth);
  }
}
