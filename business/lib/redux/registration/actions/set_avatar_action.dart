import 'dart:typed_data';

import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetAvatarAction extends ReduxAction<AppState> {
  SetAvatarAction({required this.avatar});

  final ({Uint8List bytes, String name})? avatar;

  @override
  AppState reduce() => state.copyWith.registration(avatar: avatar);
}
