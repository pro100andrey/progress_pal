import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/log_in/actions/log_in_with_email_action.dart';
import 'package:business/redux/log_in/actions/set_email_action.dart';
import 'package:business/redux/log_in/actions/set_password_action.dart';
import 'package:business/redux/log_in/log_in_selectors.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/log_in_page.dart';

import '../common/validators.dart';
import '../navigation/navigation.dart';
import 'widgets/language_menu_button_connector.dart';
import 'widgets/theme_mode_icon_button_connector.dart';

class LogInPageConnector extends StatelessWidget {
  const LogInPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => LogInPage(
      isWaiting: vm.isWaiting,
      themeModeSelector: const ThemeModeIconButtonConnector(),
      languageSelector: const LanguageMenuButtonConnector(),
      email: vm.email,
      password: vm.password,
      onForgotPasswordPressed: vm.onForgotPasswordPressed,
      onLogInPressed: vm.onLogInPressed,
      onRegisterPressed: vm.onRegisterPressed,
    ),
  );
}

/// Factory that creates a view-model  for the StoreConnector.
class _Factory extends VmFactory<AppState, LogInPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final email = selectLogInEmail(state);
    final password = selectLogInPassword(state);
    final sessionIsValid = selectSessionIsValid(state);
    // Show waiting if a login is in progress or if the session is currently
    // being validated (which might involve a navigation refresh).
    final logInIsWaiting = isWaiting(LogInWithEmailAction) || sessionIsValid;

    return _Vm(
      isWaiting: logInIsWaiting,
      email: ValueChangedVm(
        value: email,
        validator: (v) {
          final error = emailValidator(v);
          return error;
        },
        onChanged: (v) => dispatchSync(SetEmailAction(email: v)),
      ),
      password: ValueChangedVm(
        value: password,
        validator: passwordValidator.call,
        onChanged: (v) => dispatchSync(SetPasswordAction(password: v)),
      ),
      onLogInPressed: () async {
        final result = await dispatchAndWait(LogInWithEmailAction());
        if (result.isCompletedOk) {
          navigation.refresh();
        }
      },
      onForgotPasswordPressed: navigation.goToForgotPassword,
      onRegisterPressed: navigation.goToRegistration,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.isWaiting,
    required this.email,
    required this.password,
    required this.onLogInPressed,
    required this.onForgotPasswordPressed,
    required this.onRegisterPressed,
  });

  final bool isWaiting;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final VoidCallback onLogInPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onRegisterPressed;

  @override
  List<Object?> get props => [email, password, isWaiting];
}
