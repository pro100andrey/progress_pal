import '../../redux/app_state.dart';

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
