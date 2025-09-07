import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../image/avatar_selector.dart';
import '../inputs/confirm_password_input.dart';
import '../inputs/email_input.dart';
import '../inputs/full_name_input.dart';
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
    required this.onRegisterPressed,
    required this.onBackToLogInPressed,
    super.key,
  });

  final AvatarSelectorVm avatar;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final Future<bool> Function() onRegisterPressed;
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
              title: S.current.registration,
              description: S.current.registrationInstructions,
            ),
            AvatarSelector(vm: avatar),
            FullNameInput(vm: fullName),
            EmailInput(vm: email),
            PasswordInput(vm: password),
            ConfirmPasswordInput(vm: confirmPassword),
            ShadButton(
              width: 120,
              onPressed: () async => _validateForm(formKey, context),
              child: Text(S.current.signUp),
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
      final result = await onRegisterPressed();

      if (context.mounted && result) {
        ShadToaster.of(context).show(
          ShadToast(
            title: Text(S.current.successful),
            description: Text(
              S.current.registrationEmailSent(email.value!),
            ),
          ),
        );
      }
    }
  }
}
