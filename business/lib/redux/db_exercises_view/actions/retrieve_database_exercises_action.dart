import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../current_profile/current_profile_selectors.dart';
import '../../exercises/actions/add_exercises_action.dart';

class RetrieveDBExercisesAction extends ReduxAction<AppState>
    with BaseWrapError {
  @override
  Future<AppState> reduce() async {
    final currentUser = selectCurrentProfile(state)!;

    final filterBuffer = StringBuffer('is_system=true');
    if (currentUser.isNormalUser) {
      filterBuffer.write('&& status="active"');
    } 

    final resultFilter = filterBuffer.toString();

    final list = await getPB.x.exercises.getList(
      page: 1,
      perPage: 20,
      filter: resultFilter,
      sort: '-created',
    );

    dispatchSync(AddExercisesAction(items: list.items.lock), notify: false);

    final view = list.items.map((item) => item.id).toIList();

    return state.copyWith.dbExercisesView(view: view);
  }
}
