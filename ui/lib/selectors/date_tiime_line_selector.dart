import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/value_changed.dart';

class DateTimeLineSelectorVm extends Equatable {
  const DateTimeLineSelectorVm({
    required this.locale,
    required this.firstDate,
    required this.focusedDate,
  });

  final String locale;
  final DateTime firstDate;
  final ValueChangedVm<DateTime> focusedDate;

  @override
  List<Object?> get props => [locale, firstDate, focusedDate];
}

class DateTimeLineSelector extends StatelessWidget {
  const DateTimeLineSelector({
    required this.vm,
    super.key,
  });

  final DateTimeLineSelectorVm vm;

  @override
  Widget build(BuildContext context) => EasyDateTimeLinePicker(
    focusedDate: vm.focusedDate.value,
    firstDate: vm.firstDate,
    lastDate: DateTime.now(),
    timelineOptions: const TimelineOptions(
      height: 80,
    ),
    headerOptions: const HeaderOptions(
      headerType: HeaderType.viewOnly,
    ),
    selectionMode: const SelectionMode.autoCenter(),
    locale: Locale(vm.locale),
    onDateChange: (date) {
      if (date != vm.focusedDate.value) {
        vm.focusedDate.onChangedSync(date);
      }
    },
  );
}
