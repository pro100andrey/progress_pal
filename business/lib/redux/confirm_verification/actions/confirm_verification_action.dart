import 'package:async_redux/async_redux.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';

class ConfirmVerificationAction extends ReduxAction<AppState> with WaitingFor {
  ConfirmVerificationAction({required this.token});

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
