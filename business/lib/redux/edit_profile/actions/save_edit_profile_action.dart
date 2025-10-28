import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;
import 'package:pb/collections.dart';
import 'package:pb/models.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../current_profile/current_profile_selectors.dart';
import '../../models/image_source.dart';
import '../edit_profile_selectors.dart';

class SaveEditProfileAction extends ReduxAction<AppState> with BaseWrapError {
  @override
  Future<AppState?> reduce() async {
    final fullName = selectEditProfileFullName(state);
    final birthdate = selectEditProfileBirthdate(state);
    final avatar = selectEditProfileAvatar(state);
    final avatarIsChanged = selectEditProfileAvatarIsChanged(state);
    final currentUser = selectCurrentProfile(state)!;
    final deleteAvatar = avatarIsChanged && avatar is NoneImageSource;

    final result = await getPB.x.users.update(
      currentUser.id,
      body: UpdateUserBody(
        name: fullName,
        birthdate: birthdate,
        deleteAvatar: deleteAvatar,
      ),
      files: [
        if (avatar is MemoryImageSource)
          http.MultipartFile.fromBytes(
            'avatar',
            avatar.bytes,
            filename: avatar.name,
          ),
      ],
    );

    // Update the avatar in the state only if it was changed and a new avatar
    // was uploaded
    if (avatar is MemoryImageSource) {
      final user = User(result);

      final avatarUrl = user.avatarUrl(getPB.baseURL);

      final imageSource = switch (avatarUrl) {
        null => const NoneImageSource(),
        final String url => NetworkImageSource(
          url: url,
          name: url.split('/').last,
        ),
      };

      return state.copyWith.editProfile(avatar: imageSource);
    }

    return null;
  }
}
