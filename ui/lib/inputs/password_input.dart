import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class PasswordInput extends InputFormField {
  PasswordInput({required super.vm, super.key})
    : super(
        id: 'password',
        placeholder: Text(S.current.password),
        leading: const Icon(LucideIcons.key100),
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
