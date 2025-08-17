import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class FirstNameInput extends InputFormField {
  FirstNameInput({required super.vm, super.key})
    : super(
        id: 'first_name',
        placeholder: Text(S.current.firstName),
        leading: const Icon(LucideIcons.tally1100),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
      );
}
