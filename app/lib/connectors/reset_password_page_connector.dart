import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/reset_password/actions/reset_password_action.dart';
import 'package:business/redux/reset_password/actions/set_confirm_password_action.dart';
import 'package:business/redux/reset_password/actions/set_password_action.dart';
import 'package:business/redux/reset_password/actions/set_reset_password_token_action.dart';
import 'package:business/redux/reset_password/reset_password_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/reset_password_page.dart';

import '../common/validators.dart';
import '../navigation/navigation.dart';

class ResetPasswordPageConnector extends StatelessWidget {
  const ResetPasswordPageConnector({required this.token, super.key});

  final String token;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    onInit: (store) =>
        store.dispatch(SetResetPasswordTokenAction(token: token)),
    builder: (context, vm) => ResetPasswordPage(
      password: vm.password,
      confirmPassword: vm.confirmPassword,
      onResetPasswordPressed: vm.onResetPasswordPressed,
      onBackToLogInPressed: vm.onBackToLogInPressed,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ResetPasswordPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final password = selectResetPasswordPassword(state);
    final confirmPassword = selectResetPasswordConfirmPassword(state);

    return _Vm(
      password: ValueChangedVm(
        value: password,
        validator: passwordValidator.call,
        onChanged: (v) => dispatchSync(SetPasswordAction(password: v)),
      ),
      confirmPassword: ValueChangedVm(
        value: confirmPassword,
        validator: (v) {
          final confirmPasswordError = passwordValidator(v);
          final passwordsMatchError = passwordsMatchValidator(password, v);

          return confirmPasswordError ?? passwordsMatchError;
        },
        onChanged: (v) =>
            dispatchSync(SetConfirmPasswordAction(confirmPassword: v)),
      ),
      onResetPasswordPressed: () async {
        final status = await dispatchAndWait(ResetPasswordAction());

        if (status.isCompletedOk) {
          navigation.goToLogIn();
        }

        return status.isCompletedOk;
      },
      onBackToLogInPressed: navigation.goToLogIn,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.password,
    required this.confirmPassword,
    required this.onResetPasswordPressed,
    required this.onBackToLogInPressed,
  });

  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final Future<bool> Function() onResetPasswordPressed;
  final VoidCallback onBackToLogInPressed;

  @override
  List<Object?> get props => [password, confirmPassword];
}
