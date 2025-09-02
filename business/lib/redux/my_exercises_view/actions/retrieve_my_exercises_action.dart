import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../exercises/actions/add_exercises_action.dart';

class RetrieveMyExercisesAction extends ReduxAction<AppState> with WaitingFor {
  @override
  Future<AppState> reduce() async {
    final collection = ExercisesCollection(getPocketBase);

    final items = await collection.getFullList();
    dispatchSync(AddExercisesAction(items: items.lock), notify: false);

    final view = items.map((item) => item.id).toIList();

    return state.copyWith.myExercisesView(view: view);
  }
}
