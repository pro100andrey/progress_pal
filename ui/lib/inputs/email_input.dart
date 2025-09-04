import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class EmailInput extends ShadInputFormField {
  EmailInput({required this.vm, super.key})
    : super(
        id: 'email',
        placeholder: Text(S.current.email),
        leading: const Icon(LucideIcons.mail100),
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        initialValue: vm.value,
        onChanged: vm.onChanged,
      );

  final ValueChangedVm<String?> vm;
}
