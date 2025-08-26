import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SaveSessionAction extends ReduxAction<AppState> {
  SaveSessionAction({required this.value});

  final String value;

  @override
  AppState reduce() => state.copyWith();
}
