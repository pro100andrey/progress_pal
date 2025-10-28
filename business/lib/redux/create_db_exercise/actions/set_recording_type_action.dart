import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetRecordingTypeAction extends ReduxAction<AppState> {
  SetRecordingTypeAction({required this.recordingTypeId});

  final String recordingTypeId;

  @override
  AppState reduce() =>
      state.copyWith.createDbExercise(recordingTypeId: recordingTypeId);
}
