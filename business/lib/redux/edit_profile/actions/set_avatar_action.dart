import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../models/image_source.dart';

class SetAvatarAction extends ReduxAction<AppState> {
  SetAvatarAction({required this.avatar});

  final ImageSource avatar;

  @override
  AppState reduce() => state.copyWith.editProfile(avatar: avatar);
}
