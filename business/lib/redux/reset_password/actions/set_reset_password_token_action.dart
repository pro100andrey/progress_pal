import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetResetPasswordTokenAction extends ReduxAction<AppState> {
  SetResetPasswordTokenAction({required this.token});

  final String token;

  @override
  AppState reduce() => state.copyWith.resetPassword(token: token);
}
