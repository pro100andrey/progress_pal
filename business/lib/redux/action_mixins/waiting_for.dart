import 'package:async_redux/async_redux.dart';
import 'package:pocketbase/pocketbase.dart';

mixin WaitingRef<St> on ReduxAction<St> {
  @override
  void before() => dispatchSync(WaitAction.add(flag, ref: ref));

  @override
  void after() => dispatchSync(WaitAction.remove(flag, ref: ref));

  Object get ref;
  Object get flag;
}

mixin BaseWrapError<St> on ReduxAction<St> {
  @override
  Object? wrapError(Object error, StackTrace stackTrace) {
    if (error is ClientException) {
      final message = error.response['message'];

      return UserException(null, reason: message ?? '${error.statusCode}');
    } else {
      return error;
    }
  }
}
