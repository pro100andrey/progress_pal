import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/exercises/exercises_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:business/redux/my_exercises_view/actions/delete_my_exercise_action.dart';
import 'package:business/redux/my_exercises_view/actions/retrieve_my_exercises_action.dart';
import 'package:business/redux/my_exercises_view/my_exercises_view_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/cards/my_exercise_card.dart';
import 'package:ui/items/muscle_group_item.dart';
import 'package:ui/pages/my_exercises_page.dart';
import 'package:ui/popovers/my_exercise_actions.dart';

import '../map/equipment.dart';
import '../map/muscule_groups.dart';
import 'dialogs/create_my_exercise_dialog_connector.dart';

class MyExercisesConnector extends StatelessWidget {
  const MyExercisesConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    onInit: (store) => store.dispatchAndWait(RetrieveMyExercisesAction()),
    vm: () => _Factory(this),
    builder: (context, vm) => MyExercisesPage(
      createExerciseDialog: const CreateMyExerciseDialogConnector(),
      isWaiting: vm.isWaiting,
      exercises: vm.exercises,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, MyExercisesConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final view = selectMyExercisesView(state);
    final myExercisesIsWaiting = isWaiting(RetrieveMyExercisesAction);
    final language = selectLanguage(state);

    final exercises = view
        .map((id) {
          final exercise = selectExerciseById(state, id: id);
          final title = exercise.title.$;
          final instructions = exercise.instructions?.$;

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

          final equipment = selectEquipmentById(
            state,
            id: exercise.equipmentId,
          );

          return MyExerciseCardVm(
            title: title,
            instructions: instructions,
            muscleGroups: muscleGroups,
            actions: MyExerciseActionsVm(
              isDeleting: selectMyExercisesIsDeleting(
                state,
                exerciseId: exercise.id,
              ),
              onEditPressed: () {},
              onDeletePressed: () => dispatchAndWait(
                DeleteMyExerciseAction(exerciseId: exercise.id),
              ),
            ),
            equipmentType: mapSlugToEquipmentType(equipment.slug),
          );
        })
        .toList(growable: false);

    return _Vm(
      isWaiting: myExercisesIsWaiting,
      exercises: exercises,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.exercises,
    required this.isWaiting,
  });

  final List<MyExerciseCardVm> exercises;
  final bool isWaiting;

  @override
  List<Object?> get props => [exercises, isWaiting];
}
