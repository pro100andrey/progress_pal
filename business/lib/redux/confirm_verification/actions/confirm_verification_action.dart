import 'package:async_redux/async_redux.dart';

import '../../../service_locator.dart';
import '../../app_state.dart';

class ConfirmVerificationAction extends ReduxAction<AppState> {
  ConfirmVerificationAction({required this.token});

  @override
  void before() => dispatchSync(WaitAction.add(this));

  @override
  void after() {
    dispatchSync(
      WaitAction.remove(this),
    );
  }

  final String token;

  @override
  Future<AppState?> reduce() async {
    try {
      await getPocketBase.collection('users').confirmVerification(token);
    } on Exception catch (_) {
      return state.copyWith.confirmVerification(success: false);
    }

    return state.copyWith.confirmVerification(success: true);
  }
}
