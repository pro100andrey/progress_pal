import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/create_db_exercise/actions/create_db_exercise_action.dart';
import 'package:business/redux/create_db_exercise/actions/dispose_create_exercise_action.dart';
import 'package:business/redux/create_db_exercise/actions/init_create_exercise_action.dart';
import 'package:business/redux/create_db_exercise/actions/set_equipment_action.dart';
import 'package:business/redux/create_db_exercise/actions/set_image_action.dart';
import 'package:business/redux/create_db_exercise/actions/set_instructions_action.dart';
import 'package:business/redux/create_db_exercise/actions/set_muscle_group_action.dart';
import 'package:business/redux/create_db_exercise/actions/set_recording_type_action.dart';
import 'package:business/redux/create_db_exercise/actions/set_title_action.dart';
import 'package:business/redux/create_db_exercise/create_db_exercise_selectors.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/models/image_source.dart';
import 'package:business/redux/models/supported_lagnuage.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:business/redux/recording_types/recording_types_selectors.dart';
import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pb/models.dart';
import 'package:ui/dialogs/create_db_exercise_dialog.dart';
import 'package:ui/image/model.dart';
import 'package:ui/inputs/select_form_filed.dart';
import 'package:ui/models/language.dart';
import 'package:ui/models/value_changed.dart';

import '../../common/validators.dart';

class CreateDbExerciseDialogConnector extends StatelessWidget {
  const CreateDbExerciseDialogConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    onInit: (store) => store.dispatchSync(InitCreateExerciseAction()),
    onDispose: (store) => store.dispatchSync(DisposeCreateExerciseAction()),
    builder: (context, vm) => CreateDbExerciseDialog(
      images: vm.images,
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
    extends VmFactory<AppState, CreateDbExerciseDialogConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final title = selectCreateDbExerciseTitle(state);
    final instructions = selectCreateDbExerciseInstructions(state);
    final muscleGroupIds = selectCreateDbExerciseMuscleGroupIds(state);
    final equipmentId = selectCreateDbExerciseEquipmentId(state)!;
    final equipmentIdx = selectEquipmentIndexById(state, id: equipmentId);
    final recordingTypeId = selectCreateDbExerciseRecordingTypeId(state)!;
    final recordingTypeIdx = selectRecordingTypeIndexById(
      state,
      id: recordingTypeId,
    );
    final language = selectLanguage(state);
    final exerciseImages = selectCreateDbExerciseImages(state);

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

    final images = exerciseImages
        .map((e) => ImageVm.memory(bytes: e.bytes, name: e.name))
        .toList(growable: false);

    final supportedLanguages = SupportedLanguage.values
        .map(
          (e) => LanguageVm(locale: e.locale, short: e.short, title: e.title),
        )
        .toList(growable: false);

    return _Vm(
      images: ValueChangedVm(
        value: images,
        validator: (v) {
          final result = nonEmptyIterableValidator(v);
          return result;
        },
        onChanged: (v) {
          final images = v
              .cast<MemoryImageVm>()
              .map(
                (image) =>
                    MemoryImageSource(bytes: image.bytes, name: image.name),
              )
              .toList(growable: false);

          return dispatchSync(
            SetImageAction(
              images: images,
            ),
          );
        },
      ),
      title: MultiLangValueChangedVm(
        values: title?.unlock,
        defaultLanguage: supportedLanguages.first,
        supportedLanguages: supportedLanguages,
        onChanged: (value) => dispatchSync(SetTitleAction(title: value)),
        validator: (value) {
          for (final e in supportedLanguages) {
            final text = value![e.locale];

            if (text != null && text.isNotEmpty) {
              continue;
            }

            return 'Title required for ${e.title}';
          }
          return null;
        },
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
      instructions: MultiLangValueChangedVm(
        values: instructions?.unlock,
        supportedLanguages: supportedLanguages,
        defaultLanguage: supportedLanguages.first,
        onChanged: (value) =>
            dispatchSync(SetInstructionsAction(instructions: value)),
        validator: (value) {
          for (final e in supportedLanguages) {
            final delta = value![e.locale];

            if (delta != null && delta.isNotEmpty) {
              continue;
            }

            return 'Instructions required for ${e.title}';
          }
          return null;
        },
      ),

      onCreatePressed: () async {
        final status = await dispatchAndWait(CreateDbExerciseAction());

        return status.isCompletedOk;
      },
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.images,
    required this.title,
    required this.instructions,
    required this.muscleGroup,
    required this.equipment,
    required this.recordingType,
    required this.onCreatePressed,
  });

  final ValueChangedVm<List<ImageVm>> images;
  final MultiLangValueChangedVm<String> title;
  final MultiLangValueChangedVm<Delta?> instructions;
  final SelectMultipleInputVm muscleGroup;
  final SelectInputVm equipment;
  final SelectInputVm recordingType;
  final Future<bool> Function() onCreatePressed;

  @override
  List<Object?> get props => [
    images,
    title,
    instructions,
    muscleGroup,
    equipment,
    recordingType,
  ];
}
