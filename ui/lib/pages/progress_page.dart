import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/value_changed.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({required this.dateSelector, super.key});

  final DateTimeLineSelectorVm dateSelector;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        DateTimeLineSelector(vm: dateSelector),
      ],
    ),
  );
}

class DateTimeLineSelectorVm extends Equatable {
  const DateTimeLineSelectorVm({
    required this.firstDate,
    required this.focusedDate,
  });

  final DateTime firstDate;
  final ValueChangedVm<DateTime> focusedDate;

  @override
  List<Object?> get props => [focusedDate];
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
    timelineOptions: const TimelineOptions(height: 86),
    selectionMode: const SelectionMode.autoCenter(),
    onDateChange: (date) {
      if (date != vm.focusedDate.value) {
        vm.focusedDate.onChangedSync(date);
      }
    },
  );
}
