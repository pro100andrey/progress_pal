import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class FullNameInput extends InputFormField {
  FullNameInput({required super.vm, super.key})
    : super(
        id: 'fullName',
        placeholder: Text(S.current.fullName),
        leading: const Icon(LucideIcons.userCheck100),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
      );
}
