import '../app_state.dart';
import 'actions/forgot_password_action.dart';

/// returns waiting value
bool selectForgotPasswordIsWaiting(AppState state) =>
    state.wait.isWaitingForType<ForgotPasswordAction>();

/// Returns email value
String? selectForgotPasswordEmail(AppState state) => state.forgotPassword.email;
