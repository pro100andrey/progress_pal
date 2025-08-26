import 'package:async_redux/async_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'confirm_verification/models/confirm_verification_state.dart';
import 'connectivity/models/connectivity_state.dart';
import 'forgot_password/models/forgot_password_state.dart';
import 'log_in/models/log_in_state.dart';
import 'registration/models/registration_state.dart';
import 'reset_password/models/reset_password_state.dart';
import 'session/models/session_state.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    required ConnectivityState connectivity,
    required LogInState logIn,
    required RegistrationState registration,
    required ForgotPasswordState forgotPassword,
    required ResetPasswordState resetPassword,
    required ConfirmVerificationState confirmVerification,
    required SessionState session,
    required Wait wait,
  }) = _AppState;

  factory AppState.initial() => const AppState(
    connectivity: ConnectivityState(),
    logIn: LogInState(),
    registration: RegistrationState(),
    forgotPassword: ForgotPasswordState(),
    resetPassword: ResetPasswordState(),
    confirmVerification: ConfirmVerificationState(),
    session: SessionState(),
    wait: Wait.empty,
  );
}
