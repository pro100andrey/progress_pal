import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../buttons/primary_button.dart';
import '../forms/auth_form.dart';
import '../forms/base_form.dart';
import '../inputs/email_input.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';

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
    body: AuthForm(
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.welcomeBack,
            style: ShadTheme.of(context).textTheme.h2,
          ),
          BaseForm(
            formBuilder: (formKey) => Column(
              spacing: 16,
              children: [
                EmailInput(vm: email),
                PasswordInput(vm: password),
                Align(
                  alignment: Alignment.centerRight,
                  child: ShadButton.link(
                    onPressed: onPressedForgotPassword,
                    child: Text(S.current.forgotPassword),
                  ),
                ),
                PrimaryButton(
                  title: S.current.submit,
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      onPressedLogIn?.call();
                    }
                  },
                ),
                const ShadSeparator.horizontal(
                  thickness: 1,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.dontHaveAccountYet,
                      style: ShadTheme.of(
                        context,
                      ).textTheme.muted,
                    ),
                    ShadButton.link(
                      onPressed: onPressedRegister,
                      child: Text(S.current.signup),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
