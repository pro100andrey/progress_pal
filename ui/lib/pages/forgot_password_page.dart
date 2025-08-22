import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../forms/auth_form.dart';
import '../forms/base_form.dart';
import '../inputs/email_input.dart';
import '../models/value_changed.dart';
import '../tiles/auth_header.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({
    required this.isWaiting,
    required this.email,
    required this.onPressedResetPassword,
    required this.onPressedBackToLogin,
    super.key,
  });

  final bool isWaiting;
  final ValueChangedVm<String?> email;
  final VoidCallback? onPressedResetPassword;
  final VoidCallback onPressedBackToLogin;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: AuthForm(
      child: BaseForm(
        builder: (formKey) => Column(
          spacing: 16,
          children: [
            AuthHeader(
              title: S.current.forgotPassword,
              description: S.current.forgotPasswordInstructions,
            ),
            EmailInput(vm: email),
            ShadButton(
              onPressed: () => onPressedResetPassword,
              leading: const Icon(LucideIcons.mail),
              child: Text(S.current.sendResetLink),
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
}
