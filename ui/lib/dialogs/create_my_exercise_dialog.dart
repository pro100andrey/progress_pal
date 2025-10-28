import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../forms/base_form.dart';
import '../inputs/equipment_form_field.dart';
import '../inputs/exercise_title_input.dart';
import '../inputs/instructions_form_filed.dart';
import '../inputs/muscle_group_form_filed.dart';
import '../inputs/recording_type_form_field.dart';
import '../inputs/select_form_filed.dart';
import '../models/value_changed.dart';

class CreateMyExerciseDialog extends StatelessWidget {
  const CreateMyExerciseDialog({
    required this.title,
    required this.instructions,
    required this.muscleGroup,
    required this.equipment,
    required this.recordingType,
    required this.onCreatePressed,
    super.key,
  });

  final ValueChangedVm<String?> title;
  final ValueChangedVm<String?> instructions;
  final SelectMultipleInputVm muscleGroup;
  final SelectInputVm equipment;
  final SelectInputVm recordingType;
  final Future<bool> Function() onCreatePressed;

  @override
  Widget build(BuildContext context) => BaseForm(
    builder: (_, state) => AlertDialog(
      scrollable: true,
      constraints: const BoxConstraints.tightFor(width: 700),
      title: Text(S.current.createExercise),
      actions: [
        TextButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Text(S.current.cancel),
        ),
        ElevatedButton(
          onPressed: () => _validateForm(state, context),
          child: Text(S.current.create),
        ),
      ],
      content: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExerciseTitleFormFiled(vm: title),
          MuscleGroupFormField(vm: muscleGroup),
          EquipmentFormFiled(vm: equipment),
          RecordingTypeInput(vm: recordingType),
          InstructionsFormFiled(vm: instructions),
        ],
      ),
    ),
  );

  // ignore: avoid_void_async
  void _validateForm(BaseFormState state, BuildContext context) async {
    if (state.validateAndSave()) {
      final result = await onCreatePressed();
      if (context.mounted && result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(S.current.successful),
                Text(S.current.exerciseCreatedSuccessfully),
              ],
            ),
          ),
        );

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    }
  }
}
