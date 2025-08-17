import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetLastNameAction extends ReduxAction<AppState> {
  SetLastNameAction({required this.lastName});

  final String lastName;

  @override
  AppState reduce() => state.copyWith.registration(lastName: lastName);
}
