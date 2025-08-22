import '../app_state.dart';
import 'actions/confirm_verification_action.dart';

/// Returns waiting true if registration confirm verification is in progress
bool selectConfirmVerificationIsWaiting(AppState state) =>
    state.wait.isWaitingForType<ConfirmVerificationAction>();

/// Returns success true if registration confirm verification was successful
bool selectConfirmVerificationSuccess(AppState state) =>
    state.confirmVerification.success;
