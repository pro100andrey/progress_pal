import 'package:async_redux/async_redux.dart';
import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../app_state.dart';

class SetInstructionsAction extends ReduxAction<AppState> {
  SetInstructionsAction({required this.instructions});

  final Map<String, Delta?>? instructions;

  @override
  AppState reduce() =>
      state.copyWith.createDbExercise(instructions: instructions?.toIMap());
}
