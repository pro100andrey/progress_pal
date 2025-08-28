import '../app_state.dart';

/// Returns the session's pbAuth value.
String? selectSessionPBAuth(AppState state) => state.session.pbAuth;

/// Returns true if the session is valid.
bool selectSessionIsValid(AppState state) =>
    selectSessionPBAuth(state) != null && getPocketBase.authStore.isValid;

CurrentUser? selectSessionCurrentUser(AppState state) =>
    state.session.currentUser;

bool selectSessionIsLoggedIn(AppState state) =>
    selectSessionCurrentUser(state) != null;
