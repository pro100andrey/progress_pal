import '../app_state.dart';
import 'actions/reset_password_action.dart';

/// returns waiting value
bool selectResetPasswordIsWaiting(AppState state) =>
    state.wait.isWaitingForType<ResetPasswordAction>();

/// Returns password value
String? selectResetPasswordPassword(AppState state) =>
    state.resetPassword.password;

/// Returns confirm password value
String? selectResetPasswordConfirmPassword(AppState state) =>
    state.resetPassword.confirmPassword;

String? selectResetPasswordToken(AppState state) =>
    state.resetPassword.token;
