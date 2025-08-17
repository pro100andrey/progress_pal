import 'package:async_redux/async_redux.dart';

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
    final firstName = selectRegistrationFirstName(state)!;
    final lastName = selectRegistrationLastName(state)!;
    final email = selectRegistrationEmail(state)!;
    final password = selectRegistrationPassword(state)!;

    // try {
    //   final record = await getPocketBase
    //       .collection('users')
    //       .create(
    //         body: {
    //           'email': email,
    //           'emailVisibility': true,
    //           'firstName': firstName,
    //           'lastName': lastName,
    //           'password': password,
    //           'passwordConfirm': password,
    //         },
    //       );
    // } on ClientException catch (e) {
    //   throw UserException('Error', reason: e.response['message']);
    // }

    return state.copyWith(registration: const RegistrationState());
  }
}
