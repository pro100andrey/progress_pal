import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';
import 'input_form_field.dart';

class EmailFormFiled extends InputFormField {
  EmailFormFiled({required this.vm, super.key})
    : super(
        placeholder: Text(S.current.email),
        leading: const Icon(LucideIcons.mail),
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        initialValue: vm.value,
        onChanged: vm.onChanged,
        validator: vm.validator,
        enabled: vm.enabled,
      );

  final ValueChangedVm<String?> vm;
}
