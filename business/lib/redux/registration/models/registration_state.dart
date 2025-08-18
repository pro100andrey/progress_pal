import 'package:cross_file/cross_file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    XFile? avatar,
  }) = _RegistrationState;
}
