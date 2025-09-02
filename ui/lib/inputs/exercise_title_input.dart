import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'input_form_field.dart';

class ExerciseTitleInput extends InputFormField {
  ExerciseTitleInput({required super.vm, super.key})
    : super(
        id: 'exercise_title_input',
        label: Text(S.current.exerciseTitle),
        placeholder: Text(S.current.newExercise),
        leading: const Icon(LucideIcons.pen100),
        keyboardType: TextInputType.text,
      );
}
