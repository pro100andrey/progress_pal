import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import 'input_form_field.dart';

class ExerciseTitleInput extends InputFormField {
  ExerciseTitleInput({required super.vm, super.key})
    : super(
        id: 'exercise_title_input',
        label: Text(S.current.exerciseTitle),
        placeholder: Text(S.current.newExercise),

        keyboardType: TextInputType.text,
      );
}
