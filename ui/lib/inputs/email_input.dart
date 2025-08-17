import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'input_form_field.dart';

class EmailInput extends InputFormField {
  EmailInput({
    required super.vm,
    String? placeholder,
    String? description,
    super.key,
  }) : super(
         label: Text(S.current.email),
         leading: const Icon(Icons.email_outlined),
         keyboardType: TextInputType.emailAddress,
         autofillHints: const [AutofillHints.email],
         placeholder: placeholder != null ? Text(placeholder) : null,
         description: description != null ? Text(description) : null,
       );
}
