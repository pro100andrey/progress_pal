import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetSelectedDateAction extends ReduxAction<AppState> {
  SetSelectedDateAction({required this.date});

  final DateTime date;

  @override
  AppState reduce() => state.copyWith.progressView(selectedDate: date);
}
