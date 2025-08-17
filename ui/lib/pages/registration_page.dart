import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../buttons/primary_button.dart';
import '../inputs/confirm_password_input.dart';
import '../inputs/email_input.dart';
import '../inputs/password_input.dart';
import '../inputs/user_name_input.dart';
import '../models/value_changed.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.onPressedRegister,
    required this.onPressedBackToLogin,
    super.key,
  });
  final ValueChangedVm<String?> name;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final VoidCallback? onPressedRegister;
  final VoidCallback? onPressedBackToLogin;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            const SizedBox(height: 24),
            UserNameInput(vm: name),
            const SizedBox(height: 16),
            EmailInput(vm: email),
            const SizedBox(height: 16),
            PasswordInput(vm: password),
            const SizedBox(height: 16),
            ConfirmPasswordInput(vm: confirmPassword),
            const SizedBox(height: 16),
            PrimaryButton(
              title: S.current.register,
              onPressed: onPressedRegister,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onPressedBackToLogin,
              child: Text(S.current.backToLogIn),
            ),
          ],
        ),
      ],
    ),
  );
}
