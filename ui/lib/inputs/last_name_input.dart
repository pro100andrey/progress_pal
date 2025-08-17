import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class LastNameInput extends InputFormField {
  LastNameInput({required super.vm, super.key})
    : super(
        id: 'last_name',
        placeholder: Text(S.current.lastName),
        leading: const Icon(LucideIcons.tally2100),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
      );
}
