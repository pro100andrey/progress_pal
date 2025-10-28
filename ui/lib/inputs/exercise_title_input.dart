import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../models/value_changed.dart';
import 'input_form_field.dart';

class ExerciseTitleFormFiled extends InputFormField {
  ExerciseTitleFormFiled({required this.vm, super.key})
    : super(
        label: Text(S.current.exerciseTitle),
        placeholder: Text(S.current.newExercise),
        keyboardType: TextInputType.text,
        initialValue: vm.value,
        onChanged: vm.onChanged,
        validator: vm.validator,
      );

  final ValueChangedVm<String?> vm;
}
