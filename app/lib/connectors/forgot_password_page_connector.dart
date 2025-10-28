import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/forgot_password/actions/forgot_password_action.dart';
import 'package:business/redux/forgot_password/actions/set_email_action.dart';
import 'package:business/redux/forgot_password/forgot_password_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/forgot_password_page.dart';

import '../common/validators.dart';
import '../navigation/navigation.dart';

class ForgotPasswordPageConnector extends StatelessWidget {
  const ForgotPasswordPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => ForgotPasswordPage(
      isWaiting: vm.isWaiting,
      email: vm.email,
      onResetPasswordPressed: vm.onResetPasswordPressed,
      onBackToLoginPressed: vm.onBackToLoginPressed,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ForgotPasswordPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final email = selectForgotPasswordEmail(state);

    return _Vm(
      isWaiting: false,
      email: ValueChangedVm(
        value: email,
        validator: emailValidator.call,
        onChanged: (v) => dispatchSync(SetEmailAction(email: v)),
      ),
      onResetPasswordPressed: () async {
        final status = await dispatchAndWait(ForgotPasswordAction());
        if (status.isCompletedOk) {
          navigation.goToLogIn();
        }

        return status.isCompletedOk;
      },
      onBackToLoginPressed: navigation.goToLogIn,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.isWaiting,
    required this.email,
    required this.onResetPasswordPressed,
    required this.onBackToLoginPressed,
  });

  final bool isWaiting;
  final ValueChangedVm<String?> email;
  final Future<bool> Function() onResetPasswordPressed;
  final VoidCallback onBackToLoginPressed;

  @override
  List<Object?> get props => [isWaiting, email];
}
