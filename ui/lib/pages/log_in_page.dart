import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../buttons/styled_elevated_button.dart';
import '../containers/auth_from_container.dart';
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

  final ValueChangedWithErrorVm<String?> email;
  final ValueChangedWithErrorVm<String?> password;
  final VoidCallback? onPressedLogIn;
  final VoidCallback onPressedForgotPassword;
  final VoidCallback onPressedRegister;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        AuthFormContainer(
          title: S.current.logIn,
          children: [
            ShadInput(
              placeholder: const Text('Password'),
              obscureText: true,
              leading: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(LucideIcons.lock),
              ),
              trailing: ShadButton(
                width: 24,
                height: 24,
                padding: EdgeInsets.zero,
                child: const Icon(LucideIcons.eyeOff, size: 16),
                // icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 16),
            ShadInputFormField(
              id: 'username',
              label: const Text('Username'),
              placeholder: const Text('Enter your username'),
              description: const Text('This is your public display name.'),
            ),
            const SizedBox(height: 16),
            EmailInput(vm: email),
            const SizedBox(height: 16),
            PasswordInput(vm: password),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onPressedForgotPassword,
                child: Text(S.current.forgotPassword),
              ),
            ),
            const SizedBox(height: 16),
            StyledElevatedButton(
              title: S.current.logIn,
              onPressed: onPressedLogIn,
            ),
            const SizedBox(height: 16),
            StyledElevatedButton(
              title: S.current.register,
              onPressed: onPressedRegister,
            ),
          ],
        ),
      ],
    ),
  );
}
