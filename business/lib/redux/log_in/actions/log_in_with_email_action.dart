import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../service_locator.dart';
import '../../app_state.dart';
import '../log_in_selectors.dart';
import '../models/log_in_state.dart';

class LogInWithEmailAction extends ReduxAction<AppState> {
  @override
  void before() => dispatchSync(WaitAction.add(this));

  @override
  void after() {
    dispatchSync(WaitAction.remove(this), notify: false);

    dispatchSync(
      UpdateStateAction.withReducer(
        (st) => state.copyWith(logIn: const LogInState()),
      ),
    );
  }

  @override
  Future<AppState?> reduce() async {
    final email = selectLogInEmail(state)!;
    final password = selectLogInPassword(state)!;

    try {
      await getPocketBase.collection('users').authWithPassword(email, password);
    } on ClientException catch (e) {
      throw UserException('Error', reason: e.response['message']);
    }

    return null;
  }
}
