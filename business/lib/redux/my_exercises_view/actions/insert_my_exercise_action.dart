import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';
import '../../exercises/actions/add_exercises_action.dart';
import '../my_exercises_view_selectors.dart';

class InsertMyExerciseAction extends ReduxAction<AppState> {
  InsertMyExerciseAction({required this.exercise, required this.atIndex});

  final Exercise exercise;
  final int atIndex;

  @override
  AppState reduce() {
    dispatchSync(AddExercisesAction(items: [exercise].lock), notify: false);

    final view = selectMyExercisesView(state);
    final updatedView = view.insert(atIndex, exercise.id);

    return state.copyWith.myExercisesView(view: updatedView);
  }
}
