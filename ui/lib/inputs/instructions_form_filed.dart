import 'package:flutter/widgets.dart';
import 'package:localization/generated/l10n.dart';

import 'textarea_input_form_field.dart';

class InstructionsFormFiled extends TextareaInputFormFiled {
  InstructionsFormFiled({required super.vm, super.key})
    : super(
        label: Text(S.current.instructions),
        placeholder: Text(S.current.typeYourInstructionsHere),
      );
}
