import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../inputs/confirm_password_input.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    required this.password,
    required this.confirmPassword,
    required this.onPressedResetPassword,
    required this.onPressedBackToLogin,
    super.key,
  });

  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final VoidCallback? onPressedResetPassword;
  final VoidCallback? onPressedBackToLogin;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            const SizedBox(height: 24),
            PasswordInput(vm: password),
            const SizedBox(height: 16),
            ConfirmPasswordInput(vm: confirmPassword),
            const SizedBox(height: 16),

            ShadButton(
              onPressed: () => onPressedResetPassword,
              child: Text(S.current.resetPassword),
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
