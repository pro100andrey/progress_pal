import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../forms/base_form.dart';
import '../forms/form_container.dart';
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
  final Future<bool> Function() onPressedResetPassword;
  final VoidCallback onPressedBackToLogin;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FormContainer(
      centered: true,
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
              onPressed: () => _validateForm(formKey, context),
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

  Future<void> _validateForm(
    GlobalKey<ShadFormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.saveAndValidate()) {
      final result = await onPressedResetPassword();

      if (context.mounted && result) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text(S.current.successful),
            description: Text(
              S.current.forgotPasswordEmailSent(email.value!),
            ),
          ),
        );
      }
    }
  }
}
