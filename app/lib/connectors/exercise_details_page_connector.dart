import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/exercises/exercises_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/model.dart';
import 'package:ui/pages/exercise_details_page.dart';

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
    final preview = previews.isEmpty
        ? const ImageVm.none()
        : ImageVm.network(url: previews.first);

    final title = exercise.title.get(language.locale)!;
    final instructions = exercise.instructions!.get(language.locale)!;
    final muscleGroups = exercise.muscleGroupIds
        .map((id) {
          final mg = selectMuscleGroupById(state, id: id);
          return mg.name.get(language.locale)!;
        })
        .toList(growable: false);

    return _Vm(
      title: title,
      preview: preview,
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
    required this.instructions,
    required this.muscleGroups,
  });

  final String title;
  final ImageVm preview;
  final String instructions;
  final List<String> muscleGroups;

  @override
  List<Object?> get props => [title, preview, instructions, muscleGroups];
}
