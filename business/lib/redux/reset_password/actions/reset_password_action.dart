import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../models/reset_password_state.dart';
import '../reset_password_selectors.dart';

class ResetPasswordAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final password = selectResetPasswordPassword(state)!;
    final confirmPassword = selectResetPasswordConfirmPassword(state)!;
    final token = selectResetPasswordToken(state)!;

    await getPB
        .collection('users')
        .confirmPasswordReset(token, password, confirmPassword);

    return state.copyWith(resetPassword: const ResetPasswordState());
  }
}
