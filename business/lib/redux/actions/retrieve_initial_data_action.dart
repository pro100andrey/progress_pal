import 'package:async_redux/async_redux.dart';

import '../app_state.dart';
import '../equipment/actions/retrieve_equipments_action.dart';
import '../equipment/equipments_selectors.dart';
import '../muscle_groups/actions/retrieve_muscle_groups_action.dart';
import '../muscle_groups/muscle_groups_selectors.dart';
import '../recording_types/actions/retrieve_recording_types_action.dart';
import '../recording_types/recording_types_selectors.dart';
import '../session/actions/refresh_session_action.dart';

class RetrieveInitialDataAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // Order is important!
    // 1. Refresh session to ensure auth is valid.
    await dispatchAndWait(RefreshSessionAction());

    // 2. Retrieve initial data
    final actions = await dispatchAndWaitAll([
      RetrieveMuscleGroupsAction(),
      RetrieveEquipmentsAction(),
      RetrieveRecordingTypesAction(),
    ]);
  

    if (actions.any((action) => action.status.isCompletedFailed)) {
      throw const UserException('Failed to retrieve initial data');
    }

    return null;
  }
}

bool selectRetrieveInitialDataIsAvailable(AppState state) {
  final muscleGroupsView = selectMuscleGroupsByView(state);
  final equipmentView = selectEquipmentsView(state);
  final recordingTypesView = selectRecordingTypesView(state);

  return muscleGroupsView.isNotEmpty &&
      equipmentView.isNotEmpty &&
      recordingTypesView.isNotEmpty;
}
