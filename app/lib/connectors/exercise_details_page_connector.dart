import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/exercises/exercises_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/model.dart';
import 'package:ui/items/equipment_item.dart';
import 'package:ui/items/muscle_group_item.dart';
import 'package:ui/pages/exercise_details_page.dart';

import '../map/equipment.dart';
import '../map/muscule_groups.dart';

class ExerciseDetailsPageConnector extends StatelessWidget {
  const ExerciseDetailsPageConnector({required this.exerciseId, super.key});

  final String exerciseId;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => ExerciseDetailsPage(
      title: vm.title,
      preview: vm.preview,
      equipment: vm.equipment,
      instructions: vm.instructions,
      muscleGroups: vm.muscleGroups,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ExerciseDetailsPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final language = selectLanguage(state);
    final exercise = selectExerciseById(state, id: connector.exerciseId);

    final previews = selectMyExercisesPreviews(state, id: connector.exerciseId);
    final firstPreview = previews.firstOrNull;
    final preview = firstPreview == null
        ? const ImageVm.noImage()
        : ImageVm.network(url: firstPreview.url, name: firstPreview.name);

    final title = selectExerciseLocalizedTitle(
      state,
      id: connector.exerciseId,
      language: language,
    );
    final instructions = selectExerciseLocalizedInstructions(
      state,
      id: connector.exerciseId,
      language: language,
    );

    final muscleGroups = exercise.muscleGroupIds
        .map((id) {
          final mg = selectMuscleGroupById(state, id: id)!;
          final name = mg.name.getString(language.locale)!;
          final slug = mg.slug;

          return MuscleGroupItemVm(
            name: name,
            type: mapSlugToMuscleGroupType(slug),
            onPressed: null,
          );
        })
        .toList(growable: false);

    final equipment = selectEquipmentById(state, id: exercise.equipmentId);

    return _Vm(
      title: title,
      preview: preview,
      equipment: EquipmentItemVm(
        name: equipment.name.getString(language.locale)!,
        type: mapSlugToEquipmentType(equipment.slug),
        onPressed: null,
      ),
      instructions: instructions,
      muscleGroups: muscleGroups,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.title,
    required this.preview,
    required this.equipment,
    required this.instructions,
    required this.muscleGroups,
  });

  final String title;
  final ImageVm preview;
  final EquipmentItemVm equipment;
  final Delta instructions;
  final List<MuscleGroupItemVm> muscleGroups;

  @override
  List<Object?> get props => [
    title,
    preview,
    equipment,
    instructions,
    muscleGroups,
  ];
}
