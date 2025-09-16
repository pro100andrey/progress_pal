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
    selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
    captionLayout: ShadCalendarCaptionLayout.dropdown,
    placeholder: Text(S.current.birthdate),
    initialValue: vm.value,
    buttonPadding: const EdgeInsets.symmetric(horizontal: 12),
    hideWeekdayNames: true,
    hideNavigation: true,
    closeOnTapOutside: false,
    onChanged: vm.onChanged,
    validator: vm.validator,
    formatDate: (date) => DateFormat.yMd().format(date),
    fromMonth: DateTime(1950),
    toMonth: DateTime.now(),
    closeOnSelection: true,
    allowDeselection: false,
  );
}
