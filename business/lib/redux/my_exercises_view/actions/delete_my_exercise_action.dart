import 'package:async_redux/async_redux.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';

import '../../app_state.dart';
import '../../exercises/actions/delete_exercise_action.dart';
import '../my_exercises_view_selectors.dart';

class DeleteMyExerciseAction extends ReduxAction<AppState>
    with WaitingRef, BaseWrapError {
  DeleteMyExerciseAction({required this.exerciseId});

  static String kFlag = 'delete_my_exercise';

  final String exerciseId;

  @override
  Object get ref => exerciseId;

  @override
  Object get flag => DeleteMyExerciseAction.kFlag;

  @override
  Future<AppState> reduce() async {
    await getPB.x.exercises.delete(exerciseId);

    dispatchSync(
      DeleteExerciseAction(exerciseId: exerciseId),
      notify: false,
    );

    final view = selectMyExercisesView(state);
    final updatedView = view.remove(exerciseId);

    return state.copyWith.myExercisesView(view: updatedView);
  }
}
