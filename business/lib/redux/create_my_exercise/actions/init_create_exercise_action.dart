import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../app_state.dart';
import '../../equipment/equipments_selectors.dart';
import '../../muscle_groups/muscle_groups_selectors.dart';
import '../../recording_types/recording_types_selectors.dart';

class InitCreateExerciseAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    final muscleGroup = selectMuscleGroupBySlug(state, slug: 'other')!;
    final equipment = selectEquipmentBySlug(state, slug: 'body_weight')!;
    final recordingType = selectRecordingTypeBySlug(
      state,
      slug: 'weight_and_reps',
    )!;

    return state.copyWith.createMyExercise(
      title: null,
      muscleGroupIds: [muscleGroup.id].lock,
      equipmentId: equipment.id,
      recordingTypeId: recordingType.id,
      instructions: null,
    );
  }
}
