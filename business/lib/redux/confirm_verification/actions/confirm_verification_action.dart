import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class ConfirmVerificationAction extends ReduxAction<AppState> {
  ConfirmVerificationAction({required this.token});

  final String token;

  @override
  Future<AppState?> reduce() async {
    try {
      await getPB.collection('users').confirmVerification(token);
    } on Exception catch (_) {
      return state.copyWith.confirmVerification(success: false);
    }

    return state.copyWith.confirmVerification(success: true);
  }
}
