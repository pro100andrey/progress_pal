import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/registration/actions/confirm_verification_action.dart';
import 'package:business/redux/registration/registration_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/pages/confirm_verification_page.dart';

class ConfirmVerificationPageConnector extends StatelessWidget {
  const ConfirmVerificationPageConnector({required this.token, super.key});

  final String token;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => ConfirmVerificationPage(isWaiting: vm.isWaiting),
    onInit: (store) => store.dispatch(ConfirmVerificationAction(token: token)),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory
    extends VmFactory<AppState, ConfirmVerificationPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final isWaiting = selectRegistrationConfirmVerificationIsWaiting(state);

    return _Vm(isWaiting: isWaiting);
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({required this.isWaiting});

  final bool isWaiting;

  @override
  List<Object?> get props => [isWaiting];
}
