import 'package:flutter/widgets.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';
import 'input_form_field.dart';

class FullNameFormFiled extends InputFormField {
  FullNameFormFiled({required this.vm, super.key})
    : super(
        label: Text(S.current.fullName),
        leading: const Icon(LucideIcons.userCheck),
        keyboardType: TextInputType.name,
        autofillHints: const [AutofillHints.name],
        initialValue: vm.value,
        onChanged: vm.onChanged,
        validator: vm.validator,
      );

  final ValueChangedVm<String?> vm;
}
