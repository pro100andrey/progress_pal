import '../app_state.dart';
import '../models/image_source.dart';

/// Returns email value
String? selectRegistrationEmail(AppState state) => state.registration.email;

/// Returns birthdate value
DateTime? selectRegistrationBirthdate(AppState state) =>
    state.registration.birthdate;

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
ImageSource selectRegistrationAvatar(AppState state) =>
    state.registration.avatar;
