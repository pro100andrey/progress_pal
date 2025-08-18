import '../../redux/app_state.dart';
import 'actions/log_in_with_email_action.dart';

/// Returns waiting value
bool selectLogInWaiting(AppState state) =>
    state.wait.isWaitingForType<LogInWithEmailAction>();

/// Returns email value
String? selectLogInEmail(AppState state) => state.logIn.email;

/// Returns password value
String? selectLogInPassword(AppState state) => state.logIn.password;

/// Returns true if email & password is set
bool selectLogInDataIsSet(AppState state) {
  final email = selectLogInEmail(state) ?? '';
  final password = selectLogInPassword(state) ?? '';

  return email.isNotEmpty && password.isNotEmpty;
}
