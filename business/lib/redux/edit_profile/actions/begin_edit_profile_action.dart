import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../current_profile/current_profile_selectors.dart';

class BeginEditProfileAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    final currentUser = selectCurrentProfile(state)!;
    final avatar = selectCurrentProfileAvatar(state);

    return state.copyWith.editProfile(
      fullName: currentUser.name,
      birthdate: currentUser.birthdate,
      avatar: avatar,
    );
  }
}
