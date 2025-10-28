import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/connectivity/connectivity_selectors.dart';
import 'package:business/redux/create_db_exercise/actions/create_db_exercise_action.dart';
import 'package:business/redux/create_my_exercise/actions/create_my_exercise_action.dart';
import 'package:business/redux/edit_profile/actions/save_edit_profile_action.dart';
import 'package:business/redux/forgot_password/actions/forgot_password_action.dart';
import 'package:business/redux/log_in/actions/log_in_with_email_action.dart';
import 'package:business/redux/registration/actions/registration_action.dart';
import 'package:business/redux/reset_password/actions/reset_password_action.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/overlays/barrier_overlay.dart';
import 'package:ui/overlays/no_internet_overlay.dart';

enum _Overlay { barrier, noInternetConnection }

class TopLevelPageConnector extends StatelessWidget {
  const TopLevelPageConnector({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => Stack(
      children: [
        child!,
        if (vm.overlay == _Overlay.barrier) const BarrierOverlay(),
        if (vm.overlay == _Overlay.noInternetConnection)
          const NoInternetOverlay(),
      ],
    ),
  );
}

class _Factory extends VmFactory<AppState, TopLevelPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    _Overlay? overlay;

    if (!selectNetworkConnectionIsAvailable(state)) {
      overlay = _Overlay.noInternetConnection;
    }

    if (isWaiting(LogInWithEmailAction) ||
        isWaiting(RegistrationAction) ||
        isWaiting(ForgotPasswordAction) ||
        isWaiting(ResetPasswordAction) ||
        isWaiting(CreateMyExerciseAction) ||
        isWaiting(CreateDbExerciseAction) ||
        isWaiting(SaveEditProfileAction)) {
      overlay = _Overlay.barrier;
    }

    return _Vm(overlay: overlay);
  }
}

class _Vm extends Vm with EquatableMixin {
  _Vm({required this.overlay});

  final _Overlay? overlay;

  @override
  List<Object?> get props => [overlay];
}
