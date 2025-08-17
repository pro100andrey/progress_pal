import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'input_form_field.dart';

class EmailInput extends InputFormField {
  EmailInput({
    required super.vm,
    super.key,
  }) : super(
         placeholder: Text(S.current.email),
         leading: const Icon(Icons.email_outlined),
         keyboardType: TextInputType.emailAddress,
         autofillHints: const [AutofillHints.email],
       );
}
