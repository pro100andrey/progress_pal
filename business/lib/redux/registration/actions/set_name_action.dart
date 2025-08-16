import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetNameAction extends ReduxAction<AppState> {
  SetNameAction({required this.name});

  final String name;

  @override
  AppState reduce() => state.copyWith.registration(name: name);
}
