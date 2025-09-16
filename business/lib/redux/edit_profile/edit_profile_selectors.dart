import '../app_state.dart';
import '../session/session_selectors.dart';
import 'actions/save_edit_profile_action.dart';

bool selectEditProfileIsWaiting(AppState state) =>
    state.wait.isWaitingForType<SaveEditProfileAction>();

/// Returns full name
String selectEditProfileFullName(AppState state) => state.editProfile.fullName!;

/// Returns birthdate
DateTime selectEditProfileBirthdate(AppState state) =>
    state.editProfile.birthdate!;

/// Returns true if there are changes in the edit profile form
bool selectEditProfileHasChanges(AppState state) {
  final currentUser = selectSessionCurrentUser(state)!;
  final fullName = selectEditProfileFullName(state);
  final birthdate = selectEditProfileBirthdate(state);

  final nameChanged = currentUser.name != fullName;
  final d1 = currentUser.birthdate;
  final d2 = birthdate;
  final birthdateChanged = !d1.isAtSameMomentAs(d2);

  return nameChanged || birthdateChanged;
}
