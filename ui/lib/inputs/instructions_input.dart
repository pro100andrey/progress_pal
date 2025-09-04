import 'package:localization/generated/l10n.dart';

import 'textarea_input.dart';

class InstructionsInput extends TextareaInput {
  InstructionsInput({required super.vm, super.key})
    : super(
        label: S.current.instructions,
        placeholder: S.current.typeYourInstructionsHere,
      );
}
