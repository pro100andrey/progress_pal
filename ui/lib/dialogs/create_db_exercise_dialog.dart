import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:localization/generated/l10n.dart';

import '../forms/base_form.dart';
import '../image/model.dart';
import '../inputs/equipment_form_field.dart';
import '../inputs/exercise_images_form_filed.dart';
import '../inputs/multi_language_exprcise_form_filed.dart';
import '../inputs/multi_language_rich_instructions_form_field.dart';
import '../inputs/muscle_group_form_filed.dart';
import '../inputs/recording_type_form_field.dart';
import '../inputs/select_form_filed.dart';
import '../models/value_changed.dart';
import '../theme/scrollbar_theme.dart';

class CreateDbExerciseDialog extends StatefulWidget {
  const CreateDbExerciseDialog({
    required this.images,
    required this.title,
    required this.instructions,
    required this.muscleGroup,
    required this.equipment,
    required this.recordingType,
    required this.onCreatePressed,

    super.key,
  });

  final ValueChangedVm<List<ImageVm>> images;
  final MultiLangValueChangedVm<String?> title;
  final MultiLangValueChangedVm<Delta?> instructions;
  final SelectMultipleInputVm muscleGroup;
  final SelectInputVm equipment;
  final SelectInputVm recordingType;
  final Future<bool> Function() onCreatePressed;

  @override
  State<CreateDbExerciseDialog> createState() => _CreateDbExerciseDialogState();
}

class _CreateDbExerciseDialogState extends State<CreateDbExerciseDialog> {
  @override
  Widget build(BuildContext context) => BaseForm(
    builder: (_, state) => VisibleScrollbarTheme(
      child: AlertDialog(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            ExerciseImagesFormFiled(vm: widget.images),
            MuscleGroupFormField(vm: widget.muscleGroup),
            EquipmentFormFiled(vm: widget.equipment),
            RecordingTypeInput(vm: widget.recordingType),
            MultiLanguageExerciseFormFiled(vm: widget.title),
            MultiLanguageRichInstructionsFormField(vm: widget.instructions),
          ],
        ),
      ),
    ),
  );

  // ignore: avoid_void_async
  void _validateForm(BaseFormState state, BuildContext context) async {
    if (state.validateAndSave()) {
      final result = await widget.onCreatePressed();
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
