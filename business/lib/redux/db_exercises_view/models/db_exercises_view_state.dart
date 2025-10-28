import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'db_exercises_view_state.freezed.dart';

@freezed
abstract class DbExercisesViewState with _$DbExercisesViewState {
  const factory DbExercisesViewState({
    @Default(IListConst<String>([])) IList<String> view,
  }) = _DbExercisesViewState;
}
