import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/registration/actions/registration_action.dart';
import 'package:business/redux/registration/actions/set_avatar_action.dart';
import 'package:business/redux/registration/actions/set_confirm_password_action.dart';
import 'package:business/redux/registration/actions/set_email_action.dart';
import 'package:business/redux/registration/actions/set_full_name_action.dart';
import 'package:business/redux/registration/actions/set_password_action.dart';
import 'package:business/redux/registration/registration_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/avatar.dart';
import 'package:ui/image/avatar_selector.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/registration_page.dart';

import '../common/validators.dart';
import '../navigation/navigation.dart';

class RegistrationPageConnector extends StatelessWidget {
  const RegistrationPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => RegistrationPage(
      avatar: vm.avatar,
      fullName: vm.fullName,
      email: vm.email,
      password: vm.password,
      confirmPassword: vm.confirmPassword,
      onPressedRegister: vm.onPressedRegister,
      onPressedBackToLogin: vm.onPressedBackToLogin,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, RegistrationPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final fullName = selectRegistrationFullName(state);
    final email = selectRegistrationEmail(state);
    final password = selectRegistrationPassword(state);
    final confirmPassword = selectRegistrationConfirmPassword(state);
    final avatar = selectRegistrationAvatar(state);

    return _Vm(
      avatar: AvatarSelectorVm(
        src: AvatarSource.memory(avatar),
        onImageSelect: (xfile) => dispatchSync(SetAvatarAction(avatar: xfile)),
      ),
      fullName: ValueChangedVm(
        value: fullName,
        onChanged: (value) => dispatchSync(SetFullNameAction(fullName: value!)),
        validator: nameValidator.call,
      ),

      email: ValueChangedVm(
        value: email,
        validator: emailValidator.call,
        onChanged: (value) => dispatchSync(SetEmailAction(value!)),
      ),
      password: ValueChangedVm(
        value: password,
        validator: passwordValidator.call,
        onChanged: (value) => dispatchSync(SetPasswordAction(value!)),
      ),
      confirmPassword: ValueChangedVm(
        value: confirmPassword,
        validator: (v) {
          final confirmPasswordError = passwordValidator(v);
          final passwordsMatchError = passwordsMatchValidator(password, v);
          return confirmPasswordError ?? passwordsMatchError;
        },
        onChanged: (value) => dispatchSync(SetConfirmPasswordAction(value!)),
      ),
      onPressedRegister: () async {
        final status = await dispatchAndWait(RegistrationAction());

        if (status.isCompletedOk) {
          navigation.goToLogIn();
        }

        return status.isCompletedOk;
      },
      onPressedBackToLogin: navigation.goToLogIn,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.avatar,
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.onPressedRegister,
    required this.onPressedBackToLogin,
  });

  final AvatarSelectorVm avatar;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final Future<bool> Function() onPressedRegister;
  final VoidCallback onPressedBackToLogin;

  @override
  List<Object?> get props => [
    avatar,
    fullName,
    email,
    password,
    confirmPassword,
  ];
}
