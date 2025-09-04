import 'package:localization/generated/l10n.dart';

import 'select_input.dart';

class EquipmentInput extends SelectInput {
  EquipmentInput({required super.vm, super.minWidth, super.key})
    : super(
        id: 'equipment',
        label: S.current.equipment,
        placeholder: 'Select an equipment',
      );
}
