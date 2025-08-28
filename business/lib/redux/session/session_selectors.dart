import '../app_state.dart';

/// Returns the session's pbAuth value.
String? selectSessionPBAuth(AppState state) => state.session.pbAuth;

/// Returns true if the session is valid.
bool selectSessionIsValid(AppState state) =>
    selectSessionPBAuth(state) != null && getPocketBase.authStore.isValid;

CurrentUser? selectSessionCurrentUser(AppState state) =>
    state.session.currentUser;

String? selectSessionCurrentUserAvatarUrl(AppState state) {
  final currentUser = selectSessionCurrentUser(state);
  final hasAvatar = currentUser?.hasAvatar ?? false;

  if (!hasAvatar) {
    return null;
  }

  final resultUrl = getPocketBase.baseURL + currentUser!.avatarUrlPath;

  return resultUrl;
}

bool selectSessionIsLoggedIn(AppState state) =>
    selectSessionCurrentUser(state) != null;
