import 'dart:convert';

import 'package:async_redux/async_redux.dart';
import 'package:pb/models.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';
import '../../current_profile/actions/set_current_profile_action.dart';

class LoadSessionAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final pbAuth = await getSettingsStorage.getPBAuth();

    if (pbAuth == null) {
      return null;
    }

    final raw = jsonDecode(pbAuth) as Map<String, dynamic>;
    final model = RecordModel.fromJson(raw['model']);
    final user = User(model);
    dispatchSync(SetCurrentProfileAction(user: user), notify: false);

    return state.copyWith.session(pbAuth: pbAuth);
  }
}
