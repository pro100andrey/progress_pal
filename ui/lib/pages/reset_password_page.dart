import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../inputs/confirm_password_input.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';
import '../tiles/auth_header.dart';

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
      centered: true,
      child: BaseForm(
        builder: (context, formKey) => Column(
          spacing: 16,
          children: [
            AuthHeader(
              title: S.current.resetPassword,
              description: S.current.resetPasswordInstructions,
            ),
            PasswordInput(vm: password),
            ConfirmPasswordInput(vm: confirmPassword),
            ShadButton(
              onPressed: () async => _validateForm(formKey, context),
              child: Text(S.current.resetPassword),
            ),
            const ShadSeparator.horizontal(
              thickness: 1,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            TextButton(
              onPressed: onBackToLogInPressed,
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
      final result = await onResetPasswordPressed();

      if (context.mounted && result) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text(S.current.successful),
            description: Text(S.current.resetPasswordSuccess),
          ),
        );
      }
    }
  }
}
