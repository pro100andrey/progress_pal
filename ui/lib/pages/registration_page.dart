import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../avatar/avatar_selector.dart';
import '../forms/auth_form.dart';
import '../forms/base_form.dart';
import '../inputs/confirm_password_input.dart';
import '../inputs/email_input.dart';
import '../inputs/full_name.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';
import '../tiles/auth_header.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    required this.avatar,
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.onPressedRegister,
    required this.onPressedBackToLogin,
    super.key,
  });

  final AvatarSelectorVm avatar;
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
        builder: (formKey) => Column(
          spacing: 16,
          children: [
            AuthHeader(
              title: S.current.registration,
              description: S.current.registrationInstructions,
            ),
            AvatarSelector(vm: avatar),
            FullName(vm: fullName),
            EmailInput(vm: email),
            PasswordInput(vm: password),
            ConfirmPasswordInput(vm: confirmPassword),
            ShadButton(
              width: 120,
              onPressed: () => _validateForm(formKey),
              child: Text(S.current.signUp),
            ),
            const ShadSeparator.horizontal(
              thickness: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
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

  void _validateForm(GlobalKey<ShadFormState> formKey) {
    if (formKey.currentState!.saveAndValidate()) {
      onPressedRegister?.call();
    }
  }
}
