import 'package:async_redux/async_redux.dart';

import '../models/___state_name____state.dart';
import '../../app_state.dart';

class Retrieve___StateName___Action extends ReduxAction<AppState> {
  Retrieve___StateName___Action();

  @override
  void before() => dispatchSync(WaitAction.add(this));

  @override
  void after() => dispatchSync(WaitAction.remove(this), notify: false);

  Future<AppState?> reduce() async => Future.value(state);
}
