import 'package:async_redux/async_redux.dart';

import '../../action_mixins/waiting.dart';
import '../../app_state.dart';

class Retrieve___StateName___Action extends ReduxAction<AppState>
    with WaitingFor {
  Future<AppState?> reduce() async => Future.value(state);
}
