import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/confirm_verification/actions/confirm_verification_action.dart';
import 'package:business/redux/confirm_verification/confirm_verification_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/pages/confirm_verification_page.dart';

import '../navigation/navigation.dart';

class ConfirmVerificationPageConnector extends StatelessWidget {
  const ConfirmVerificationPageConnector({required this.token, super.key});

  final String token;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => ConfirmVerificationPage(
      isWaiting: vm.isWaiting,
      success: vm.success,
      onBackToLoginPressed: vm.onBackToLoginPressed,
    ),
    onInit: (store) => store.dispatch(
      ConfirmVerificationAction(token: token),
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory
    extends VmFactory<AppState, ConfirmVerificationPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final confirmationIsWaiting = isWaiting(ConfirmVerificationAction);
    final success = selectConfirmVerificationSuccess(state);

    return _Vm(
      isWaiting: confirmationIsWaiting,
      success: success,
      onBackToLoginPressed: navigation.goToLogIn,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.isWaiting,
    required this.success,
    required this.onBackToLoginPressed,
  });

  final bool isWaiting;
  final bool success;
  final VoidCallback onBackToLoginPressed;

  @override
  List<Object?> get props => [isWaiting, success];
}
