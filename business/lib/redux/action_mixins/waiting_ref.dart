import 'package:async_redux/async_redux.dart';

mixin WaitingRef<St> on ReduxAction<St> {
  @override
  void before() => dispatchSync(WaitAction.add(flag, ref: ref));

  @override
  void after() => dispatchSync(WaitAction.remove(flag, ref: ref));

  Object get ref;
  Object get flag;
}
