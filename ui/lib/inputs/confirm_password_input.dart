import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'input_form_field.dart';

class ConfirmPasswordInput extends InputFormField {
  ConfirmPasswordInput({required super.vm, super.key})
    : super(
        label: Text(S.current.confirmPassword),
        leading: const Icon(Icons.check_outlined),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );
}
