import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../app_state.dart';

class SetTitleAction extends ReduxAction<AppState> {
  SetTitleAction({required this.title});

  final Map<String, String?>? title;

  @override
  AppState reduce() => state.copyWith.createDbExercise(title: title?.toIMap());
}
