import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pb/collections.dart';

import '../../app_state.dart';
import '../../current_profile/current_profile_selectors.dart';
import '../../equipment/equipments_selectors.dart';
import '../../exercises/actions/add_exercises_action.dart';
import '../../muscle_groups/muscle_groups_selectors.dart';
import '../../recording_types/recording_types_selectors.dart';

class RetrieveMyExercisesAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    await waitCondition(
      (state) =>
          selectMuscleGroupsView(state).isNotEmpty &&
          selectRecordingTypesView(state).isNotEmpty &&
          selectEquipmentsView(state).isNotEmpty,
    );

    final currentUser = selectCurrentProfile(state)!;
    final items = await getPB.x.exercises.getFullList(
      filter: 'created_by.id="${currentUser.id}" && is_system=false',
      sort: '-created',
    );

    dispatchSync(AddExercisesAction(items: items.lock), notify: false);

    final view = items.map((item) => item.id).toIList();

    return state.copyWith.myExercisesView(view: view);
  }
}
