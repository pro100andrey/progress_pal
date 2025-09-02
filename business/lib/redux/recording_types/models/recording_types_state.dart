import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pb/models.dart';

part 'recording_types_state.freezed.dart';

@freezed
abstract class RecordingTypesState with _$RecordingTypesState {
  const factory RecordingTypesState({
    @Default(IMapConst<String, RecordingType>({}))
    IMap<String, RecordingType> table,
    @Default(IListConst<String>([])) IList<String> view,
  }) = _RecordingTypesState;
}
