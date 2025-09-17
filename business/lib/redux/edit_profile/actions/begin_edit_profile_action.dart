import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../models/image_source.dart';
import '../../session/session_selectors.dart';

class BeginEditProfileAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    final currentUser = selectSessionCurrentUser(state)!;
    final avatar = selectSessionCurrentUserAvatarUrl(state);
    final imageSource = switch (avatar) {
      null => const NoneImageSource(),
      final String url => NetworkImageSource(url: url),
    };

    return state.copyWith.editProfile(
      fullName: currentUser.name,
      birthdate: currentUser.birthdate,
      avatar: imageSource,
    );
  }
}
