import '../app_state.dart';
import '../models/image_source.dart';
import '../session/session_selectors.dart';
import 'actions/save_edit_profile_action.dart';

bool selectEditProfileIsWaiting(AppState state) =>
    state.wait.isWaitingForType<SaveEditProfileAction>();

/// Returns full name
String selectEditProfileFullName(AppState state) => state.editProfile.fullName!;

/// Returns birthdate
DateTime selectEditProfileBirthdate(AppState state) =>
    state.editProfile.birthdate!;

ImageSource selectEditProfileAvatar(AppState state) => state.editProfile.avatar;

/// Returns true if avatar is changed
bool selectEditProfileAvatarIsChanged(AppState state) {
  final currentUserAvatar = selectSessionCurrentUserAvatarUrl(state);
  final avatar = selectEditProfileAvatar(state);

  return avatar !=
      switch (currentUserAvatar) {
        null => const NoneImageSource(),
        final String url => NetworkImageSource(url: url),
      };
}

/// Returns true if full name is changed
bool selectEditProfileFullNameIsChanged(AppState state) {
  final currentUser = selectSessionCurrentUser(state)!;
  final fullName = selectEditProfileFullName(state);

  return currentUser.name != fullName;
}

/// Returns true if birthdate is changed
bool selectEditProfileBirthdateIsChanged(AppState state) {
  final currentUser = selectSessionCurrentUser(state)!;
  final birthdate = selectEditProfileBirthdate(state);

  return currentUser.birthdate != birthdate;
}

/// Returns true if there are changes in the edit profile form
bool selectEditProfileHasChanges(AppState state) {
  final fullNameIsChanged = selectEditProfileFullNameIsChanged(state);
  final birthdateIsChanged = selectEditProfileBirthdateIsChanged(state);
  final avatarIsChanged = selectEditProfileAvatarIsChanged(state);

  final result = fullNameIsChanged || birthdateIsChanged || avatarIsChanged;

  return result;
}
