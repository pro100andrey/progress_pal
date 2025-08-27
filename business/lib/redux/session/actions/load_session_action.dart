import 'package:async_redux/async_redux.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';

class LoadSessionAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final pbAuth = await getSettingsStorage.getPBAuth();

    return state.copyWith.session(pbAuth: pbAuth);
  }
}
