import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_verification_state.freezed.dart';

@freezed
abstract class ConfirmVerificationState with _$ConfirmVerificationState {
  const factory ConfirmVerificationState({
    @Default(false) bool success,
  }) = _ConfirmVerificationState;
}
