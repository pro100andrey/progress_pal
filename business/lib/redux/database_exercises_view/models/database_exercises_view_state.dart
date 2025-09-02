import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'database_exercises_view_state.freezed.dart';

@freezed
abstract class DatabaseExercisesViewState with _$DatabaseExercisesViewState {
  const factory DatabaseExercisesViewState({
    @Default(IListConst<String>([])) IList<String> view,
  }) = _DatabaseExercisesViewState;
}
