import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../exercises/actions/add_exercises_action.dart';

class RetrieveDatabaseExercisesAction extends ReduxAction<AppState>
    with WaitingFor {
  @override
  Future<AppState> reduce() async {
    final collection = ExercisesCollection(getPocketBase);

    final list = await collection.getList(
      page: 1,
      perPage: 20,
      filter: 'is_system=true',
      sort: '-created',
    );

    dispatchSync(AddExercisesAction(items: list.items.lock), notify: false);

    final view = list.items.map((item) => item.id).toIList();

    return state.copyWith.databaseExercisesView(view: view);
  }
}
