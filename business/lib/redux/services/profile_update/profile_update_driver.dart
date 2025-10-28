import 'package:async_redux/async_redux.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';
import '../../current_profile/actions/set_current_profile_action.dart';
import 'profile_update.dart';

class ProfileUpdateDriver implements ProfileUpdateServiceDriverInterface {
  ProfileUpdateDriver({required Store<AppState> store}) : _store = store;

  final Store<AppState> _store;

  @override
  void onUpdateProfile(User user) =>
      _store.dispatchSync(SetCurrentProfileAction(user: user));

  @override
  void onDeleteProfile(User user) =>
      _store.dispatchSync(SetCurrentProfileAction(user: null));
}
