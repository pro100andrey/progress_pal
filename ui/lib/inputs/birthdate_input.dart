import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class BirthdateInput extends StatelessWidget {
  const BirthdateInput({required this.vm, super.key});

  final ValueChangedVm<DateTime?> vm;

  @override
  Widget build(BuildContext context) => ShadDatePickerFormField(
    width: double.infinity,
    anchor: ShadAnchor.center,
    placeholder: Text(S.current.birthdate),
    onChanged: print,
    validator: vm.validator,
  );
}
