import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import 'select_form_filed.dart';

class EquipmentFormFiled extends StatelessWidget {
  const EquipmentFormFiled({required this.vm, super.key});
  final SelectInputVm vm;

  @override
  Widget build(BuildContext context) => SelectFormField(
    label: Text(S.current.equipment),
    placeholder: Text(S.current.selectAnEquipment),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    initialValue: vm.initialValue,
    onChanged: vm.onSelect,
    items: vm.items,
  );
}
