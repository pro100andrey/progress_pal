import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class ___ActionName___Action extends ReduxAction<AppState> {
  ___ActionName___Action({required this.value});

  final String value;

  @override
  AppState reduce() => state.copyWith();
}
