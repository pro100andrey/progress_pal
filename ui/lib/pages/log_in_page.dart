import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../dev/text_version.dart';
import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../inputs/email_form_field.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({
    required this.languageSelector,
    required this.themeModeSelector,
    required this.email,
    required this.password,
    required this.onLogInPressed,
    required this.onForgotPasswordPressed,
    required this.onRegisterPressed,
    required this.isWaiting,
    super.key,
  });

  final bool isWaiting;
  final Widget languageSelector;
  final Widget themeModeSelector;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final VoidCallback onLogInPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onRegisterPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [languageSelector, themeModeSelector],
      backgroundColor: Colors.transparent,
    ),
    body: Visibility(
      visible: !isWaiting,
      child: FormContainer(
        title: S.current.welcomeBack,
        description: S.current.loginInstructions,
        footer: const TextVersion(),
        child: BaseForm(
          builder: (context, formKey) => Column(
            spacing: 16,
            children: [
              EmailFormFiled(vm: email),
              PasswordFormField(vm: password),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onForgotPasswordPressed,
                  child: Text(S.current.forgotPassword),
                ),
              ),
              FilledButton(
                onPressed: () => _validateForm(formKey),
                child: Text(S.current.signIn),
              ),
              const Divider(),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    S.current.dontHaveAccountYet,
                  ),
                  TextButton(
                    onPressed: onRegisterPressed,
                    child: Text(S.current.signUp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _validateForm(BaseFormState state) {
    if (state.validateAndSave()) {
      onLogInPressed();
    }
  }
}
