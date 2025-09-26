import 'package:localization/generated/l10n.dart';

import 'select_multiple_input.dart';

class MuscleGroupInput extends SelectMultipleInput {
  MuscleGroupInput({required super.vm, super.minWidth, super.key})
    : super(
        id: 'muscle_group',
        label: S.current.muscleGroup,
        placeholder: 'Select a muscle group',
      );
}
