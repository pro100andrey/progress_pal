import '../app_state.dart';

/// Returns password value
String? selectResetPasswordPassword(AppState state) =>
    state.resetPassword.password;

/// Returns confirm password value
String? selectResetPasswordConfirmPassword(AppState state) =>
    state.resetPassword.confirmPassword;

/// Returns token value
String? selectResetPasswordToken(AppState state) => state.resetPassword.token;
