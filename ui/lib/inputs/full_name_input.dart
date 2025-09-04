import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class FullNameInput extends ShadInputFormField {
  FullNameInput({required this.vm, super.key})
    : super(
        id: 'fullName',
        placeholder: Text(S.current.fullName),
        leading: const Icon(LucideIcons.userCheck100),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
        initialValue: vm.value,
        onChanged: vm.onChanged,
        validator: vm.validator,
      );

  final ValueChangedVm<String?> vm;
}
