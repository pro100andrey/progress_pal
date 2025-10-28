import '../app_state.dart';

/// Returns the session's pbAuth value.
String? selectSessionPBAuth(AppState state) => state.session.pbAuth;

/// Returns true if the session is valid.
bool selectSessionIsValid(AppState state) =>
    selectSessionPBAuth(state) != null && getPB.authStore.isValid;
