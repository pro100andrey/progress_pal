import 'package:async_redux/async_redux.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';
import '../../pb/models/current_user.dart';

class SaveSessionAction extends ReduxAction<AppState> {
  SaveSessionAction({required this.pbAuth});

  final String? pbAuth;

  @override
  Future<AppState> reduce() async {
    pbAuth != null
        ? await getSettingsStorage.setPBAuth(pbAuth)
        : await getSettingsStorage.deletePBAuth();

    final currentUser = getPocketBase.authStore.record;

    return state.copyWith.session(
      pbAuth: pbAuth,
      currentUser: pbAuth != null ? CurrentUser(currentUser!) : null,
    );
  }
}
