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
    anchor: const ShadAnchor(
      childAlignment: Alignment.center,
      overlayAlignment: Alignment.center,
    ),
    captionLayout: ShadCalendarCaptionLayout.dropdown,
    placeholder: Text(S.current.birthdate),
    initialValue: vm.value,
    onChanged: vm.onChanged,
    validator: vm.validator,
    formatDate: (date) => DateFormat.yMd().format(date),
    closeOnSelection: true,
    fromMonth: DateTime(1950),
    toMonth: DateTime.now(),
  );
}
