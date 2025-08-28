import 'package:async_redux/async_redux.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../app_state.dart';
import '../forgot_password_selectors.dart';
import '../models/forgot_password_state.dart';

class ForgotPasswordAction extends ReduxAction<AppState> {
  @override
  void before() => dispatchSync(WaitAction.add(this));

  @override
  void after() => dispatchSync(WaitAction.remove(this));

  @override
  Future<AppState> reduce() async {
    final email = selectForgotPasswordEmail(state)!;

    try {
      await getPocketBase.collection('users').requestPasswordReset(email);
    } on ClientException catch (e) {
      throw UserException(null, reason: e.response['message']);
    }

    return state.copyWith(forgotPassword: const ForgotPasswordState());
  }
}
