import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pb/models.dart';

part 'exercises_state.freezed.dart';

@freezed
abstract class ExercisesState with _$ExercisesState {
  const factory ExercisesState({
    @Default(IMapConst<String, Exercise>({})) IMap<String, Exercise> table,
  }) = _ExercisesState;
}
