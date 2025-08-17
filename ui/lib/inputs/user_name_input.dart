import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'input_form_field.dart';

class UserNameInput extends InputFormField {
  UserNameInput({required super.vm, super.key})
    : super(
        label: Text(S.current.name),
        leading: const Icon(Icons.person_outline),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
      );
}
