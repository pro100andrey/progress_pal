import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_exercises_view_state.freezed.dart';

@freezed
abstract class MyExercisesViewState with _$MyExercisesViewState {
  const factory MyExercisesViewState({
    @Default(IListConst<String>([])) IList<String> view,
  }) = _MyExercisesViewState;
}
