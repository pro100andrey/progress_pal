import '../app_state.dart';

/// Returns success true if registration confirm verification was successful
bool selectConfirmVerificationSuccess(AppState state) =>
    state.confirmVerification.success;
