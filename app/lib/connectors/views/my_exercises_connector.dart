import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/exercises/exercises_selectors.dart';
import 'package:business/redux/my_exercises_view/actions/delete_my_exercise_action.dart';
import 'package:business/redux/my_exercises_view/actions/retrieve_my_exercises_action.dart';
import 'package:business/redux/my_exercises_view/my_exercises_view_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/actions/my_exercise_actions.dart';
import 'package:ui/cards/my_exercise_card.dart';
import 'package:ui/views/my_exercises.dart';

class MyExercisesConnector extends StatelessWidget {
  const MyExercisesConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    onInit: (store) => store.dispatchAndWait(RetrieveMyExercisesAction()),
    onDispose: (store) => debugPrint('MyExercisesConnector disposed'),
    vm: () => _Factory(this),
    builder: (context, vm) => MyExercises(
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
    final isWaiting = selectMyExercisesIsWaiting(state);

    final exercises = view
        .map((id) {
          final exercise = selectExerciseById(state, id: id);

          return MyExerciseCardVm(
            title: exercise.title.user,
            instructions: exercise.instructions?.user,
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
          );
        })
        .toList(growable: false);

    return _Vm(
      isWaiting: isWaiting,
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
