import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../session/session_selectors.dart';

class BeginEditProfileAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    final currentUser = selectSessionCurrentUser(state)!;

    return state.copyWith.editProfile(
      fullName: currentUser.name,
      birthdate: currentUser.birthdate,
    );
  }
}
