import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../inputs/confirm_password_form_field.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    required this.password,
    required this.confirmPassword,
    required this.onResetPasswordPressed,
    required this.onBackToLogInPressed,
    super.key,
  });

  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final Future<bool> Function() onResetPasswordPressed;
  final VoidCallback onBackToLogInPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FormContainer(
      title: S.current.resetPassword,
      description: S.current.resetPasswordInstructions,
      child: BaseForm(
        builder: (context, state) => Column(
          spacing: 16,
          children: [
            PasswordFormField(vm: password),
            ConfirmPasswordFormField(vm: confirmPassword),
            FilledButton(
              onPressed: () async => _validateForm(state, context),
              child: Text(S.current.resetPassword),
            ),
            const Divider(height: 20),
            TextButton(
              onPressed: onBackToLogInPressed,
              child: Text(S.current.backToLogIn),
            ),
          ],
        ),
      ),
    ),
  );

  Future<void> _validateForm(BaseFormState state, BuildContext context) async {
    if (state.validateAndSave()) {
      final result = await onResetPasswordPressed();

      if (context.mounted && result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(S.current.successful),
                Text(S.current.resetPasswordSuccess),
              ],
            ),
          ),
        );
      }
    }
  }
}
