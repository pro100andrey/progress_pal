import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class EmailInput extends InputFormField {
  EmailInput({
    required super.vm,
    super.key,
  }) : super(
         id: 'email',
         placeholder: Text(S.current.email),
         leading: const Icon(LucideIcons.mail100),
         keyboardType: TextInputType.emailAddress,
         autofillHints: const [AutofillHints.email],
       );
}
