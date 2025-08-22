import 'package:async_redux/async_redux.dart';
import 'package:cross_file/cross_file.dart';

import '../../app_state.dart';

class SetAvatarAction extends ReduxAction<AppState> {
  SetAvatarAction({required this.avatar});

  final XFile? avatar;

  @override
  AppState reduce() => state.copyWith.registration(avatar: avatar);
}
