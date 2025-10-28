import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetBirthdateAction extends ReduxAction<AppState> {
  SetBirthdateAction({required this.birthdate});

  final DateTime? birthdate;

  @override
  AppState reduce() => state.copyWith.registration(birthdate: birthdate);
}
