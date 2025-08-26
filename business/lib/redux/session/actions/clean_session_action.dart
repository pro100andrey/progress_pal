import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class CleanSessionAction extends ReduxAction<AppState> {
  CleanSessionAction({required this.value});

  final String value;

  @override
  AppState reduce() => state.copyWith();
}
