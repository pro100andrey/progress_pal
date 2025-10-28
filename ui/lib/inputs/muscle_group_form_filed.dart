import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import 'select_form_filed.dart';

class MuscleGroupFormField extends StatelessWidget {
  const MuscleGroupFormField({required this.vm, super.key});

  final SelectMultipleInputVm vm;

  @override
  Widget build(BuildContext context) => MultiselectFormField(
    label: Text(S.current.muscleGroup),
    placeholder: Text(S.current.selectAMuscleGroup),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    initialValue: vm.initialValues,
    onChanged: vm.onChanged,
    validator: vm.validator,
    selectTitle: Text(S.current.selectAMuscleGroup),
    items: vm.items,
  );
}
