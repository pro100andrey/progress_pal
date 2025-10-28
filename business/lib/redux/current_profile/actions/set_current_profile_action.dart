import 'package:async_redux/async_redux.dart';
import 'package:pb/models.dart';

import '../../app_state.dart';

class SetCurrentProfileAction extends ReduxAction<AppState> {
  SetCurrentProfileAction({required this.user});

  final User? user;

  @override
  AppState reduce() => state.copyWith.currentProfile(user: user);
}
