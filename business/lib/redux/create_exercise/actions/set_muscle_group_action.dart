import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetMuscleGroupAction extends ReduxAction<AppState> {
  SetMuscleGroupAction({required this.muscleGroupId});

  final String muscleGroupId;

  @override
  AppState reduce() =>
      state.copyWith.createExercise(muscleGroupId: muscleGroupId);
}
