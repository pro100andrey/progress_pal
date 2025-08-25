import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../dev/text_version.dart';
import '../forms/auth_form.dart';
import '../forms/base_form.dart';
import '../inputs/email_input.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';
import '../tiles/auth_header.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({
    required this.email,
    required this.password,
    required this.onPressedLogIn,
    required this.onPressedForgotPassword,
    required this.onPressedRegister,
    super.key,
  });

  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final VoidCallback? onPressedLogIn;
  final VoidCallback onPressedForgotPassword;
  final VoidCallback onPressedRegister;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        AuthForm(
          child: BaseForm(
            builder: (formKey) => Column(
              spacing: 16,
              children: [
                AuthHeader(
                  title: S.current.welcomeBack,
                  description: S.current.loginInstructions,
                ),
                EmailInput(vm: email),
                PasswordInput(vm: password),
                Align(
                  alignment: Alignment.centerRight,
                  child: ShadButton.link(
                    onPressed: onPressedForgotPassword,
                    child: Text(S.current.forgotPassword),
                  ),
                ),
                ShadButton(
                  width: 120,
                  onPressed: () => _validateForm(formKey),
                  child: Text(S.current.signIn),
                ),
                const ShadSeparator.horizontal(
                  thickness: 1,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      S.current.dontHaveAccountYet,
                      style: ShadTheme.of(
                        context,
                      ).textTheme.muted,
                    ),
                    ShadButton.link(
                      onPressed: onPressedRegister,
                      child: Text(S.current.signUp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          bottom: 16,
          right: 16,
          child: TextVersion(),
        ),
      ],
    ),
  );

  void _validateForm(GlobalKey<ShadFormState> formKey) {
    if (formKey.currentState!.saveAndValidate()) {
      onPressedLogIn?.call();
    }
  }
}
