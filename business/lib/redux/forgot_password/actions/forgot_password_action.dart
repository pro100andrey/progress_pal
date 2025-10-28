import 'package:async_redux/async_redux.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../forgot_password_selectors.dart';
import '../models/forgot_password_state.dart';

class ForgotPasswordAction extends ReduxAction<AppState> with BaseWrapError {
  @override
  Future<AppState> reduce() async {
    final email = selectForgotPasswordEmail(state)!;

    await getPB.collection('users').requestPasswordReset(email);

    return state.copyWith(forgotPassword: const ForgotPasswordState());
  }
}
