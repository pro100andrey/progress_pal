import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../image/editor/image_editor.dart';
import '../image/image_selector.dart';
import '../image/model.dart';
import '../inputs/birthdate_form_filed.dart';
import '../inputs/confirm_password_form_field.dart';
import '../inputs/email_form_field.dart';
import '../inputs/full_name_form_field.dart';
import '../inputs/password_input.dart';
import '../models/value_changed.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({
    required this.avatar,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.password,
    required this.confirmPassword,
    required this.onRegisterPressed,
    required this.onBackToLogInPressed,
    super.key,
  });

  final ImageSelectorVm avatar;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final ValueChangedVm<String?> password;
  final ValueChangedVm<String?> confirmPassword;
  final Future<bool> Function() onRegisterPressed;
  final VoidCallback onBackToLogInPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FormContainer(
      title: S.current.registration,
      description: S.current.registrationInstructions,
      child: BaseForm(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            ImageSelector.avatar(
              vm: avatar,
              sizeRadius: ImageVm.maxAvatarRadius,
              placeholderIconSize: ImageVm.maxAvatarRadius - 10,
              editorConfig: ImageEditorConfig.circle(
                maxImageSize: ImageVm.maxAvatarSize,
              ),
            ),
            FullNameFormFiled(vm: fullName),
            EmailFormFiled(vm: email),
            BirthdateFormFiled(vm: birthdate),
            PasswordFormField(vm: password),
            ConfirmPasswordFormField(vm: confirmPassword),
            FilledButton(
              onPressed: () async => _validateForm(state, context),
              child: Text(S.current.signUp),
            ),
            const Divider(),
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
      final result = await onRegisterPressed();

      if (context.mounted && result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(S.current.successful),
                Text(
                  S.current.registrationEmailSent(email.value!),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
