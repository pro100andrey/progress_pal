import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../app_state.dart';

class SetMuscleGroupAction extends ReduxAction<AppState> {
  SetMuscleGroupAction({required this.muscleGroupIds});

  final List<String> muscleGroupIds;

  @override
  AppState reduce() =>
      state.copyWith.createDbExercise(muscleGroupIds: muscleGroupIds.lock);
}
