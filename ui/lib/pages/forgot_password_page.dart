import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../inputs/email_form_field.dart';
import '../models/value_changed.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({
    required this.isWaiting,
    required this.email,
    required this.onResetPasswordPressed,
    required this.onBackToLoginPressed,
    super.key,
  });

  final bool isWaiting;
  final ValueChangedVm<String?> email;
  final Future<bool> Function() onResetPasswordPressed;
  final VoidCallback onBackToLoginPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FormContainer(
      title: S.current.forgotPassword,
      description: S.current.forgotPasswordInstructions,

      child: BaseForm(
        builder: (context, state) => Column(
          spacing: 16,
          children: [
            EmailFormFiled(vm: email),
            FilledButton(
              onPressed: () => _validateForm(state, context),
              // leading: const Icon(LucideIcons.mail),
              child: Text(S.current.sendResetLink),
            ),
            const Divider(),
            TextButton(
              onPressed: onBackToLoginPressed,
              child: Text(S.current.backToLogIn),
            ),
          ],
        ),
      ),
    ),
  );

  Future<void> _validateForm(
    BaseFormState state,
    BuildContext context,
  ) async {
    if (state.validateAndSave()) {
      final result = await onResetPasswordPressed();

      if (context.mounted && result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(S.current.successful),
                Text(
                  S.current.forgotPasswordEmailSent(email.value!),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
