import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../models/create_exercise_state.dart';

class DisposeCreateExerciseAction extends ReduxAction<AppState> {
  @override
  AppState reduce() =>
      state.copyWith(createExercise: const CreateExerciseState());
}
