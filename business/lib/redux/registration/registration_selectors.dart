import '../app_state.dart';
import 'actions/registration_action.dart';

/// returns waiting value
bool selectRegistrationIsWaiting(AppState state) =>
    state.wait.isWaitingForType<RegistrationAction>();

/// Returns email value
String? selectRegistrationEmail(AppState state) => state.registration.email;

/// Returns password value
String? selectRegistrationPassword(AppState state) =>
    state.registration.password;

/// Returns first name value
String? selectRegistrationFullName(AppState state) =>
    state.registration.fullName;


/// Returns confirm password value
String? selectRegistrationConfirmPassword(AppState state) =>
    state.registration.confirmPassword;

/// Returns true if email, password, confirmPassword is setted
bool selectRegistrationDataIsSet(AppState state) {
  final email = selectRegistrationEmail(state) ?? '';
  final password = selectRegistrationPassword(state) ?? '';
  final confirmPassword = selectRegistrationConfirmPassword(state) ?? '';

  return email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty;
}
