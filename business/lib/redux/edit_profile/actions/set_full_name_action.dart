import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetFullNameAction extends ReduxAction<AppState> {
  SetFullNameAction({required this.fullName});

  final String? fullName;

  @override
  AppState reduce() => state.copyWith.editProfile(fullName: fullName);
}
