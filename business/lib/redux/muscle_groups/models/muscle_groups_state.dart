import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pb/models.dart';

part 'muscle_groups_state.freezed.dart';

@freezed
abstract class MuscleGroupsState with _$MuscleGroupsState {
  const factory MuscleGroupsState({
    @Default(IMapConst<String, MuscleGroup>({}))
    IMap<String, MuscleGroup> table,
    @Default(IListConst<String>([])) IList<String> view,
  }) = _MuscleGroupsState;
}
