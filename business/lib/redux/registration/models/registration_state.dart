import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/image_source.dart';

part 'registration_state.freezed.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    String? fullName,
    String? email,
    DateTime? birthdate,
    String? password,
    String? confirmPassword,
    @Default(NoneImageSource()) ImageSource avatar,
  }) = _RegistrationState;
}
