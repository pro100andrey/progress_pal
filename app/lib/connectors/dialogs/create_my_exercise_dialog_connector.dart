import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/create_my_exercise/actions/create_my_exercise_action.dart';
import 'package:business/redux/create_my_exercise/actions/dispose_create_exercise_action.dart';
import 'package:business/redux/create_my_exercise/actions/init_create_exercise_action.dart';
import 'package:business/redux/create_my_exercise/actions/set_equipment_action.dart';
import 'package:business/redux/create_my_exercise/actions/set_instructions_action.dart';
import 'package:business/redux/create_my_exercise/actions/set_muscle_group_action.dart';
import 'package:business/redux/create_my_exercise/actions/set_recording_type_action.dart';
import 'package:business/redux/create_my_exercise/actions/set_title_action.dart';
import 'package:business/redux/create_my_exercise/create_my_exercise_selectors.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:business/redux/recording_types/recording_types_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pb/models.dart';
import 'package:ui/dialogs/create_my_exercise_dialog.dart';
import 'package:ui/inputs/select_form_filed.dart';
import 'package:ui/models/value_changed.dart';

import '../../common/validators.dart';

class CreateMyExerciseDialogConnector extends StatelessWidget {
  const CreateMyExerciseDialogConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    onInit: (store) => store.dispatchSync(InitCreateExerciseAction()),
    onDispose: (store) => store.dispatchSync(DisposeCreateExerciseAction()),
    builder: (context, vm) => CreateMyExerciseDialog(
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
class _Factory
    extends VmFactory<AppState, CreateMyExerciseDialogConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final title = selectCreateMyExerciseTitle(state);
    final instructions = selectCreateMyExerciseInstructions(state);
    final muscleGroupIds = selectCreateMyExerciseMuscleGroupIds(state);
    final equipmentId = selectCreateMyExerciseEquipmentId(state)!;
    final equipmentIdx = selectEquipmentIndexById(state, id: equipmentId);
    final recordingTypeId = selectCreateMyExerciseRecordingTypeId(state)!;
    final recordingTypeIdx = selectRecordingTypeIndexById(
      state,
      id: recordingTypeId,
    );

    final language = selectLanguage(state);

    final muscleGroupItems = selectMuscleGroupsByView(state)
        .map(
          (item) => SelectInputItem(
            label: item.name.getString(language.locale)!,
            data: item,
          ),
        )
        .toList(growable: false);

    final initialMuscleGroups = muscleGroupIds
        .map(
          (id) => muscleGroupItems.firstWhere(
            (element) => element.data.id == id,
          ),
        )
        .toList(growable: false);

    final equipmentsItems = selectEquipments(state)
        .map(
          (item) => SelectInputItem(
            label: item.name.getString(language.locale)!,
            data: item,
          ),
        )
        .toList(growable: false);

    final recordTypesItems = selectRecordingTypes(state)
        .map(
          (item) => SelectInputItem(
            label: item.name.getString(language.locale)!,
            data: item,
          ),
        )
        .toList(growable: false);

    return _Vm(
      title: ValueChangedVm(
        value: title,
        onChanged: (value) => dispatchSync(SetTitleAction(title: value!)),
        validator: requiredValidator.call,
      ),
      muscleGroup: SelectMultipleInputVm(
        initialValues: initialMuscleGroups,
        items: muscleGroupItems,
        validator: nonEmptyIterableValidator.call,
        onChanged: (values) => dispatchSync(
          SetMuscleGroupAction(
            muscleGroupIds: values
                .castItems<MuscleGroup>()
                .map((e) => e.data.id)
                .toList(growable: false),
          ),
        ),
      ),
      equipment: SelectInputVm(
        initialValue: equipmentsItems[equipmentIdx],
        items: equipmentsItems,
        validator: (value) => requiredValidator(value?.label ?? ''),
        onSelect: (value) => dispatchSync(
          SetEquipmentAction(equipmentId: value!.cast<Equipment>().id),
        ),
      ),
      recordingType: SelectInputVm(
        initialValue: recordTypesItems[recordingTypeIdx],
        items: recordTypesItems,
        validator: (value) => requiredValidator(value?.label ?? ''),
        onSelect: (value) => dispatchSync(
          SetRecordingTypeAction(
            recordingTypeId: value!.cast<RecordingType>().id,
          ),
        ),
      ),
      instructions: ValueChangedVm(
        value: instructions,
        onChanged: (value) =>
            dispatchSync(SetInstructionsAction(instructions: value!)),
      ),
      onCreatePressed: () async {
        final status = await dispatchAndWait(CreateMyExerciseAction());

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
  final SelectMultipleInputVm muscleGroup;
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
