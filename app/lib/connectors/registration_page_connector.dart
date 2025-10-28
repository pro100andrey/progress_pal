import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/models/image_source.dart';
import 'package:business/redux/registration/actions/registration_action.dart';
import 'package:business/redux/registration/actions/set_avatar_action.dart';
import 'package:business/redux/registration/actions/set_birthdate_action.dart';
import 'package:business/redux/registration/actions/set_confirm_password_action.dart';
import 'package:business/redux/registration/actions/set_email_action.dart';
import 'package:business/redux/registration/actions/set_full_name_action.dart';
import 'package:business/redux/registration/actions/set_password_action.dart';
import 'package:business/redux/registration/registration_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/image_selector.dart';
import 'package:ui/image/model.dart';
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
      birthdate: vm.birthdate,
      password: vm.password,
      confirmPassword: vm.confirmPassword,
      onRegisterPressed: vm.onRegisterPressed,
      onBackToLogInPressed: vm.onLogInPressed,
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
    final birthdate = selectRegistrationBirthdate(state);
    final password = selectRegistrationPassword(state);
    final confirmPassword = selectRegistrationConfirmPassword(state);
    final avatar = selectRegistrationAvatar(state);

    return _Vm(
      avatar: ImageSelectorVm(
        image: switch (avatar) {
          MemoryImageSource(:final bytes, :final name) => ImageVm.memory(
            bytes: bytes,
            name: name,
          ),
          _ => const ImageVm.noImage(),
        },
        onImageSelect: (v) => dispatchSync(
          SetAvatarAction(
            avatar: switch (v) {
              MemoryImageVm(:final bytes, :final name) => MemoryImageSource(
                bytes: bytes,
                name: name,
              ),
              null => const NoneImageSource(),
            },
          ),
        ),
      ),
      fullName: ValueChangedVm(
        value: fullName,
        onChanged: (v) => dispatchSync(SetFullNameAction(fullName: v)),
        validator: nameValidator.call,
      ),
      email: ValueChangedVm(
        value: email,
        validator: emailValidator.call,
        onChanged: (v) => dispatchSync(SetEmailAction(email: v)),
      ),
      birthdate: ValueChangedVm(
        value: birthdate,
        validator: (v) => requiredValidator(v?.toString() ?? ''),
        onChanged: (v) => dispatchSync(SetBirthdateAction(birthdate: v)),
      ),
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
      onRegisterPressed: () async {
        final status = await dispatchAndWait(RegistrationAction());

        if (status.isCompletedOk) {
          navigation.goToLogIn();
        }

        return status.isCompletedOk;
      },
      onLogInPressed: navigation.goToLogIn,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.avatar,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.password,
    required this.confirmPassword,
    required this.onRegisterPressed,
    required this.onLogInPressed,
  });

  final ImageSelectorVm avatar;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final Future<bool> Function() onRegisterPressed;
  final VoidCallback onLogInPressed;

  @override
  List<Object?> get props => [
    avatar,
    fullName,
    email,
    birthdate,
    password,
    confirmPassword,
  ];
}
