import 'dart:typed_data';

import '../app_state.dart';
import 'actions/confirm_verification_action.dart';
import 'actions/registration_action.dart';

/// Returns waiting true if registration confirm verification is in progress
bool selectRegistrationConfirmVerificationIsWaiting(AppState state) =>
    state.wait.isWaitingForType<ConfirmVerificationAction>();

/// Returns waiting true if registration is in progress
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

/// Returns avatar value
({Uint8List bytes, String name})? selectRegistrationAvatar(AppState state) =>
    state.registration.avatar;
