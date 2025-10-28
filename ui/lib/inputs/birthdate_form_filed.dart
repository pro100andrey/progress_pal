import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';
import 'input_form_field.dart';

class BirthdateFormFiled extends StatelessWidget {
  const BirthdateFormFiled({
    required this.vm,
    super.key,
  });

  final ValueChangedVm<DateTime?> vm;

  @override
  Widget build(BuildContext context) => DatePickerFormField(
    placeholder: Text(S.current.birthdate),
    validator: vm.validator,
    onChanged: vm.onChanged,
    initialValue: vm.value,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    currentDate: DateTime.now(),
    initialDatePickerMode: DatePickerMode.year,
    initialEntryMode: DatePickerEntryMode.input,
  );
}

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    required this.firstDate,
    required this.lastDate,
    this.placeholder,
    this.initialValue,
    this.currentDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.validator,
    this.onChanged,
    super.key,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final Widget? placeholder;
  final DateTime? initialValue;
  final DateTime? currentDate;
  final DatePickerMode initialDatePickerMode;
  final DatePickerEntryMode initialEntryMode;
  final ValueChanged<DateTime>? onChanged;
  final String? Function(DateTime?)? validator;

  @override
  DatePickerFormFieldState createState() => DatePickerFormFieldState();
}

class DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime? _selectedDate;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedDate != null && _controller.text.isEmpty) {
      final formatter = DateFormat.yMd(
        Localizations.localeOf(context).toString(),
      );
      _controller.text = formatter.format(_selectedDate!);
    }
  }

  @override
  void didUpdateWidget(covariant DatePickerFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _selectedDate) {
      _selectedDate = widget.initialValue;
      final formatter = DateFormat.yMd(
        Localizations.localeOf(context).toString(),
      );

      if (_selectedDate != null) {
        final newText = formatter.format(_selectedDate!);
        if (_controller.text != newText) {
          _controller.text = newText;
        }
      } else {
        if (_controller.text.isNotEmpty) {
          _controller.clear();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => Focus(
    canRequestFocus: false,
    onKeyEvent: (node, event) {
      if (event is KeyDownEvent &&
          (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.space)) {
        unawaited(_selectDate(context));
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    },
    child: InputFormField(
      controller: _controller,
      placeholder: widget.placeholder,
      readOnly: true,
      focusNode: _focusNode,
      leading: const Icon(LucideIcons.calendar),
      onTap: () => _selectDate(context),
      validator: (value) => widget.validator?.call(_selectedDate),
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      initialDatePickerMode: widget.initialDatePickerMode,
      initialEntryMode: widget.initialEntryMode,
      context: context,
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      currentDate: widget.currentDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;

        final formatter = DateFormat.yMd(
          Localizations.localeOf(context).toString(),
        );
        _controller.text = formatter.format(picked);
      });
      widget.onChanged?.call(picked);
    }
  }
}
