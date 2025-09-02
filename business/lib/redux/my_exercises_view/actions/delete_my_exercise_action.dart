import 'package:async_redux/async_redux.dart';
import 'package:pb/collections.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../action_mixins/waiting_ref.dart';
import '../../app_state.dart';
import '../../exercises/actions/delete_exercise_action.dart';
import '../my_exercises_view_selectors.dart';

class DeleteMyExerciseAction extends ReduxAction<AppState> with WaitingRef {
  DeleteMyExerciseAction({required this.exerciseId});

  static String kFlag = 'delete_my_exercise';

  final String exerciseId;

  @override
  Object get ref => exerciseId;

  @override
  Object get flag => DeleteMyExerciseAction.kFlag;

  @override
  Future<AppState> reduce() async {
    try {
      await getPocketBase.x.exercises.delete(exerciseId);
    } on ClientException catch (e) {
      throw UserException(null, reason: e.response['message']);
    }

    dispatchSync(
      DeleteExerciseAction(exerciseId: exerciseId),
      notify: false,
    );

    final view = selectMyExercisesView(state);
    final updatedView = view.remove(exerciseId);

    return state.copyWith.myExercisesView(view: updatedView);
  }
}
