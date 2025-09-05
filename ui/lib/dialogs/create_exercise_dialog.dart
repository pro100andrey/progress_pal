import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../forms/base_form.dart';
import '../inputs/equipment_input.dart';
import '../inputs/exercise_title_input.dart';
import '../inputs/instructions_input.dart';
import '../inputs/muscle_group_input.dart';
import '../inputs/recording_type_input.dart';
import '../inputs/select_input.dart';
import '../models/value_changed.dart';

class CreateExerciseDialogVm extends Equatable {
  const CreateExerciseDialogVm({
    required this.title,
    required this.muscleGroup,
    required this.equipment,
    required this.recordingType,
    required this.onPressedCreate,
  });

  final ValueChangedVm<String?> title;
  final SelectInputVm muscleGroup;
  final SelectInputVm equipment;
  final SelectInputVm recordingType;
  final Future<bool> Function() onPressedCreate;

  @override
  List<Object?> get props => [
    title,
    muscleGroup,
    equipment,
    recordingType,
  ];
}

class CreateExerciseDialog extends StatelessWidget {
  const CreateExerciseDialog({
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
  final SelectInputVm muscleGroup;
  final SelectInputVm equipment;
  final SelectInputVm recordingType;
  final Future<bool> Function() onCreatePressed;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: BaseForm(
      builder: (_, state) => ShadDialog(
        gap: 24,
        constraints: const BoxConstraints(maxWidth: 450),
        title: Text(S.current.createExercise),
        actions: [
          ShadButton(
            onPressed: () => _validateForm(state, context),
            child: Text(S.current.create),
          ),
        ],
        child: Column(
          spacing: 16,
          children: [
            ExerciseTitleInput(vm: title),
            MuscleGroupInput(vm: muscleGroup),
            EquipmentInput(vm: equipment),
            RecordingTypeInput(vm: recordingType),
            InstructionsInput(vm: instructions),
          ],
        ),
      ),
    ),
  );

  // ignore: avoid_void_async
  void _validateForm(
    GlobalKey<ShadFormState> formKey,
    BuildContext context,
  ) async {
    if (formKey.currentState!.saveAndValidate()) {
      final result = await onCreatePressed();
      if (context.mounted && result) {
        ShadToaster.of(context).show(
          ShadToast(
            alignment: Alignment.bottomCenter,
            closeIcon: const Icon(LucideIcons.x),
            showCloseIconOnlyWhenHovered: false,
            title: Text(S.current.successful),
            description: Text(S.current.exerciseCreatedSuccessfully),
          ),
        );

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    }
  }
}
