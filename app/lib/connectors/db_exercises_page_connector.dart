import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/current_profile/current_profile_selectors.dart';
import 'package:business/redux/db_exercises_view/actions/retrieve_database_exercises_action.dart';
import 'package:business/redux/db_exercises_view/db_exercises_view_selectors.dart';
import 'package:business/redux/exercises/exercises_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/cards/database_exercise_card.dart';
import 'package:ui/image/model.dart';
import 'package:ui/pages/db_exercises_page.dart';

import '../navigation/navigation.dart';
import 'dialogs/create_db_exercise_dialog_connector.dart';

class DbExercisesPageConnector extends StatelessWidget {
  const DbExercisesPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    shouldUpdateModel: selectCurrentProfileIsSet,
    onInit: (store) async {
      await store.dispatchAndWait(RetrieveDBExercisesAction());
    },
    builder: (context, vm) => DbExercisesPage(
      isWaiting: vm.isWaiting,
      exercises: vm.exercises,
      createExerciseDialog: !vm.canWrite
          ? null
          : const CreateDbExerciseDialogConnector(),
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, DbExercisesPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final view = selectDbExercisesView(state);
    final dbExercisesIsWaiting = isWaiting(RetrieveDBExercisesAction);
    final currentUser = selectCurrentProfile(state)!;
    final canWrite = currentUser.isAdmin || currentUser.isWriter;
    final language = selectLanguage(state);

    final exercises = view
        .map((id) {
          final exercise = selectExerciseById(state, id: id);
          final previews = selectMyExercisesPreviews(state, id: id);
          final firstPreview = previews.firstOrNull;
          final preview = firstPreview == null
              ? const ImageVm.noImage()
              : ImageVm.network(url: firstPreview.url, name: firstPreview.name);

          final title = selectExerciseLocalizedTitle(
            state,
            id: id,
            language: language,
          );

          final instructions = selectExerciseLocalizedInstructions(
            state,
            id: id,
            language: language,
          );

          final muscleGroups = exercise.muscleGroupIds
              .map((id) {
                final mg = selectMuscleGroupById(state, id: id)!;
                return mg.name.getString(language.locale)!;
              })
              .toList(growable: false);

          return DatabaseExerciseCardVm(
            preview: preview,
            title: title,
            instructions: instructions,
            muscleGroups: muscleGroups,
            onPressed: () async => navigation.pushExerciseDetails(exercise.id),
          );
        })
        .toList(growable: false);

    return _Vm(
      exercises: exercises,
      canWrite: canWrite,
      isWaiting: dbExercisesIsWaiting,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.canWrite,
    required this.exercises,
    required this.isWaiting,
  });

  final bool canWrite;
  final List<DatabaseExerciseCardVm> exercises;
  final bool isWaiting;

  @override
  List<Object?> get props => [exercises, isWaiting, canWrite];
}
