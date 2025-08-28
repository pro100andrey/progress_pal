import 'package:freezed_annotation/freezed_annotation.dart';

import '../../pb/pb.dart';

part 'session_state.freezed.dart';

@freezed
abstract class SessionState with _$SessionState {
  const factory SessionState({
    String? pbAuth,
    CurrentUser? currentUser,
  }) = _SessionState;
}
