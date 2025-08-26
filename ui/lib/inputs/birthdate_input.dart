import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class BirthdateInput extends StatelessWidget {
  const BirthdateInput({required this.vm, super.key});

  final ValueChangedVm<DateTime?> vm;

  @override
  Widget build(BuildContext context) => ShadDatePickerFormField(
    width: double.infinity,
    anchor: ShadAnchor.center,
    placeholder: const Text('Date of Birth'),
    onChanged: print,
    validator: vm.validator,
  );
}
