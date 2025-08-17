import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class PasswordInput extends InputFormField {
  PasswordInput({required super.vm, super.key})
    : super(
        id: 'password',
        label: Text(S.current.password),
        leading: const Icon(Icons.password_outlined),
        trailingBuilder: (state) => ShadButton(
          width: 24,
          height: 24,
          padding: EdgeInsets.zero,
          onPressed: state.toggleObscure,
          child: Icon(state.obscure ? LucideIcons.eyeOff : LucideIcons.eye),
        ),

        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        autofillHints: const [AutofillHints.password],
      );
}
