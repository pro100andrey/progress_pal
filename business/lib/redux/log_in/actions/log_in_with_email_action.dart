import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../session/session_selectors.dart';
import '../log_in_selectors.dart';
import '../models/log_in_state.dart';

class LogInWithEmailAction extends ReduxAction<AppState> with WaitingFor {
  @override
  Future<AppState?> reduce() async {
    final email = selectLogInEmail(state)!;
    final password = selectLogInPassword(state)!;

    try {
      await getPocketBase.collection('users').authWithPassword(email, password);
    } on ClientException catch (e) {
      throw UserException(null, reason: e.response['message']);
    }

    await store.waitCondition(
      selectSessionIsValid,
      completeImmediately: true,
      timeoutMillis: 500,
    );

    return state.copyWith(logIn: const LogInState());
  }
}
