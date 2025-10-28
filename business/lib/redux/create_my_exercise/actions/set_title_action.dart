import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetTitleAction extends ReduxAction<AppState> {
  SetTitleAction({required this.title});

  final String title;

  @override
  AppState reduce() => state.copyWith.createMyExercise(title: title);
}
