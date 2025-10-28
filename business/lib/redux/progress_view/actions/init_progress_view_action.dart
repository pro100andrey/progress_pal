import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import 'set_selected_date_action.dart';

class InitProgressViewAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    dispatchSync(SetSelectedDateAction(date: DateTime.now()), notify: false);

    return null;
  }
}
