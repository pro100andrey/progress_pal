import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'base_text_input.dart';

class UserNameInput extends BaseTextInput {
  UserNameInput({required super.vm, super.key})
    : super(
        labelText: S.current.name,
        prefixIcon: const Icon(Icons.person_outline),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
      );
}
