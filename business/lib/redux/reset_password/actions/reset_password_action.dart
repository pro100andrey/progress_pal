import 'package:async_redux/async_redux.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../models/reset_password_state.dart';
import '../reset_password_selectors.dart';

class ResetPasswordAction extends ReduxAction<AppState> with WaitingFor {
  @override
  Future<AppState> reduce() async {
    final password = selectResetPasswordPassword(state)!;
    final confirmPassword = selectResetPasswordConfirmPassword(state)!;
    final token = selectResetPasswordToken(state)!;

    try {
      await getPocketBase
          .collection('users')
          .confirmPasswordReset(token, password, confirmPassword);
    } on ClientException catch (e) {
      throw UserException(null, reason: e.response['message']);
    }

    return state.copyWith(resetPassword: const ResetPasswordState());
  }
}
