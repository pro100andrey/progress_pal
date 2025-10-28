import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetInstructionsAction extends ReduxAction<AppState> {
  SetInstructionsAction({required this.instructions});

  final String instructions;

  @override
  AppState reduce() =>
      state.copyWith.createMyExercise(instructions: instructions);
}
