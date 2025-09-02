import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pb/models.dart';

part 'session_state.freezed.dart';

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState({
    String? pbAuth,
    User? currentUser,
  }) = _SessionState;
}
