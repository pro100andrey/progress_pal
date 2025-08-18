import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../buttons/primary_button.dart';
import '../forms/auth_form.dart';
import '../forms/base_form.dart';
import '../inputs/confirm_password_input.dart';
import '../inputs/email_input.dart';
import '../inputs/full_name.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.onPressedRegister,
    required this.onPressedBackToLogin,
    super.key,
  });

  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final VoidCallback? onPressedRegister;
  final VoidCallback? onPressedBackToLogin;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: AuthForm(
      child: BaseForm(
        formBuilder: (formKey) => Column(
          spacing: 16,
          children: [
            Text(
              S.current.registration,
              style: ShadTheme.of(context).textTheme.h2,
            ),
            FullName(vm: fullName),
            EmailInput(vm: email),
            PasswordInput(vm: password),
            ConfirmPasswordInput(vm: confirmPassword),
            PrimaryButton(
              title: S.current.submit,
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  onPressedRegister?.call();
                }
              },
            ),
            TextButton(
              onPressed: onPressedBackToLogin,
              child: Text(S.current.backToLogIn),
            ),
          ],
        ),
      ),
    ),
  );
}
