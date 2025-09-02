import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class ConfirmPasswordInput extends InputFormField {
  ConfirmPasswordInput({required super.vm, super.key})
    : super(
        id: 'confirm_password',
        placeholder: Text(S.current.confirmPassword),
        leading: const Icon(LucideIcons.check100),
        trailingBuilder: (state) => ShadButton(
          width: 24,
          height: 24,
          padding: EdgeInsets.zero,
          onPressed: state.toggleObscure,
          child: Icon(
            state.obscure ? LucideIcons.eyeOff200 : LucideIcons.eye200,
          ),
        ),

        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        autofillHints: const [AutofillHints.password],
      );
}
