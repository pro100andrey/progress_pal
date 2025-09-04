import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class ExerciseTitleInput extends ShadInputFormField {
  ExerciseTitleInput({required this.vm, super.key})
    : super(
        id: 'exercise_title_input',
        label: Text(S.current.exerciseTitle),
        placeholder: Text(S.current.newExercise),
        keyboardType: TextInputType.text,
        initialValue: vm.value,
        onChanged: vm.onChanged,
      );

  final ValueChangedVm<String?> vm;
}
