import 'package:pb/models.dart';

import '../app_state.dart';

/// Returns the session's pbAuth value.
String? selectSessionPBAuth(AppState state) => state.session.pbAuth;

/// Returns true if the session is valid.
bool selectSessionIsValid(AppState state) =>
    selectSessionPBAuth(state) != null && getPocketBase.authStore.isValid;

User? selectSessionCurrentUser(AppState state) => state.session.currentUser;

String? selectSessionCurrentUserAvatarUrl(AppState state) {
  final currentUser = selectSessionCurrentUser(state);

  return currentUser?.avatarUrl(getPocketBase.baseURL);
}

bool selectSessionIsLoggedIn(AppState state) =>
    selectSessionCurrentUser(state) != null;
