import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_state.freezed.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    String? fullName,
    String? email,
    DateTime? birthdate,
    String? password,
    String? confirmPassword,
    ({Uint8List bytes, String name})? avatar,
  }) = _RegistrationState;
}
