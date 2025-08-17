import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetFirstNameAction extends ReduxAction<AppState> {
  SetFirstNameAction({required this.firstName});

  final String firstName;

  @override
  AppState reduce() => state.copyWith.registration(firstName: firstName);
}
