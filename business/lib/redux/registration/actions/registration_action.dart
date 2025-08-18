import 'package:async_redux/async_redux.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../service_locator.dart';
import '../../app_state.dart';
import '../models/registration_state.dart';
import '../registration_selectors.dart';

class RegistrationAction extends ReduxAction<AppState> {
  @override
  void before() => dispatchSync(WaitAction.add(this));

  @override
  void after() => dispatchSync(WaitAction.remove(this));

  @override
  Future<AppState?> reduce() async {
    final fullName = selectRegistrationFullName(state)!;
    final email = selectRegistrationEmail(state)!;
    final password = selectRegistrationPassword(state)!;

    try {
      await getPocketBase
          .collection('users')
          .create(
            body: {
              'email': email,
              'emailVisibility': true,
              'name': fullName,
              'password': password,
              'passwordConfirm': password,
            },
          );
    } on ClientException catch (e) {
      throw UserException('Error', reason: e.response['message']);
    }

    await getPocketBase.collection('users').requestVerification(email);

    return state.copyWith(registration: const RegistrationState());
  }
}
