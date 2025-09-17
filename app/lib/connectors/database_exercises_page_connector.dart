import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/database_exercises_view/actions/retrieve_database_exercises_action.dart';
import 'package:business/redux/database_exercises_view/database_exercises_view_selectors.dart';
import 'package:business/redux/exercises/exercises_selectors.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/cards/database_exercise_card.dart';
import 'package:ui/image/model.dart';
import 'package:ui/pages/database_exercises_page.dart';

class DatabaseExercisesPageConnector extends StatelessWidget {
  const DatabaseExercisesPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    onInit: (store) async {
      await store.dispatchAndWait(RetrieveDatabaseExercisesAction());
    },
    builder: (context, vm) => DatabaseExercisesPage(
      isWaiting: vm.isWaiting,
      exercises: vm.exercises,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory
    extends VmFactory<AppState, DatabaseExercisesPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final view = selectDatabaseExercisesView(state);
    final isWaiting = selectDatabaseExercisesIsWaiting(state);
    final language = selectLanguage(state);

    final exercises = view
        .map((id) {
          final exercise = selectExerciseById(state, id: id);

          return DatabaseExerciseCardVm(
            preview: const ImageVm.none(),
            title: exercise.title.get(language.locale)!,
            instructions: exercise.instructions!.get(language.locale)!,
          );
        })
        .toList(growable: false);

    return _Vm(
      exercises: exercises,
      isWaiting: isWaiting,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.exercises,
    required this.isWaiting,
  });

  final List<DatabaseExerciseCardVm> exercises;
  final bool isWaiting;

  @override
  List<Object?> get props => [exercises, isWaiting];
}
