import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/create_exercise/actions/create_exercise_action.dart';
import 'package:business/redux/create_exercise/actions/dispose_create_exercise_action.dart';
import 'package:business/redux/create_exercise/actions/init_create_exercise_action.dart';
import 'package:business/redux/create_exercise/actions/set_equipment_action.dart';
import 'package:business/redux/create_exercise/actions/set_instructions_action.dart';
import 'package:business/redux/create_exercise/actions/set_muscle_group_action.dart';
import 'package:business/redux/create_exercise/actions/set_recording_type_action.dart';
import 'package:business/redux/create_exercise/actions/set_title_action.dart';
import 'package:business/redux/create_exercise/create_exercise_selectors.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:business/redux/recording_types/recording_types_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/dialogs/create_exercise_dialog.dart';
import 'package:ui/inputs/select_input.dart';
import 'package:ui/models/value_changed.dart';

import '../../common/validators.dart';

class CreateExerciseDialogConnector extends StatelessWidget {
  const CreateExerciseDialogConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    onInit: (store) => store.dispatchSync(InitCreateExerciseAction()),
    onDispose: (store) => store.dispatchSync(DisposeCreateExerciseAction()),
    builder: (context, vm) => CreateExerciseDialog(
      title: vm.title,
      instructions: vm.instructions,
      muscleGroup: vm.muscleGroup,
      equipment: vm.equipment,
      recordingType: vm.recordingType,
      onCreatePressed: vm.onCreatePressed,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, CreateExerciseDialogConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final title = selectCreateExerciseTitle(state);
    final instructions = selectCreateExerciseInstructions(state);
    final muscleGroupId = selectCreateExerciseMuscleGroupId(state)!;
    final muscleGroupIdx = selectMuscleGroupIndexById(state, id: muscleGroupId);
    final equipmentId = selectCreateExerciseEquipmentId(state)!;
    final equipmentIdx = selectEquipmentIndexById(state, id: equipmentId);
    final recordingTypeId = selectCreateExerciseRecordingTypeId(state)!;
    final recordingTypeIdx = selectRecordingTypeIndexById(
      state,
      id: recordingTypeId,
    );

    final language = selectLanguage(state);

    final muscleGroupItems = selectMuscleGroups(state)
        .map(
          (item) => SelectInputItem(
            label: item.name.get(language.locale)!,
            onSelect: () => dispatchSync(
              SetMuscleGroupAction(muscleGroupId: item.id),
            ),
          ),
        )
        .toList(growable: false);

    final equipmentsItems = selectEquipments(state)
        .map(
          (item) => SelectInputItem(
            label: item.name.get(language.locale)!,
            onSelect: () =>
                dispatchSync(SetEquipmentAction(equipmentId: item.id)),
          ),
        )
        .toList(growable: false);

    final recordTypesItems = selectRecordingTypes(state)
        .map(
          (item) => SelectInputItem(
            label: item.name.get(language.locale)!,
            onSelect: () =>
                dispatchSync(SetRecordingTypeAction(recordingTypeId: item.id)),
          ),
        )
        .toList(growable: false);

    return _Vm(
      title: ValueChangedVm(
        value: title,
        onChanged: (value) => dispatchSync(SetTitleAction(title: value!)),
        validator: requiredValidator.call,
      ),
      instructions: ValueChangedVm(
        value: instructions,
        onChanged: (value) =>
            dispatchSync(SetInstructionsAction(instructions: value!)),
      ),
      muscleGroup: SelectInputVm(
        initialValue: muscleGroupItems[muscleGroupIdx],
        items: muscleGroupItems,
        validator: (value) => requiredValidator(value?.label ?? ''),
      ),
      equipment: SelectInputVm(
        initialValue: equipmentsItems[equipmentIdx],
        items: equipmentsItems,
        validator: (value) => requiredValidator(value?.label ?? ''),
      ),
      recordingType: SelectInputVm(
        initialValue: recordTypesItems[recordingTypeIdx],
        items: recordTypesItems,
        validator: (value) => requiredValidator(value?.label ?? ''),
      ),
      onCreatePressed: () async {
        final status = await dispatchAndWait(CreateExerciseAction());

        return status.isCompletedOk;
      },
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.title,
    required this.instructions,
    required this.muscleGroup,
    required this.equipment,
    required this.recordingType,
    required this.onCreatePressed,
  });

  final ValueChangedVm<String?> title;
  final ValueChangedVm<String?> instructions;
  final SelectInputVm muscleGroup;
  final SelectInputVm equipment;
  final SelectInputVm recordingType;
  final Future<bool> Function() onCreatePressed;

  @override
  List<Object?> get props => [
    title,
    instructions,
    muscleGroup,
    equipment,
    recordingType,
  ];
}
