import 'package:async_redux/async_redux.dart';

mixin WaitingFor<St> on ReduxAction<St> {
  @override
  void before() => dispatchSync(WaitAction.add(this));

  @override
  void after() => dispatchSync(WaitAction.remove(this));
}
