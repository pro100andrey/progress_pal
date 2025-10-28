import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pb/models.dart';

part 'current_profile_state.freezed.dart';

@freezed
abstract class CurrentProfileState with _$CurrentProfileState {
  const factory CurrentProfileState({
    User? user,
  }) = _CurrentProfileState;
}
