import 'package:dart_quill_delta/dart_quill_delta.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/image_source.dart';

part 'create_db_exercise_state.freezed.dart';

@freezed
abstract class CreateDbExerciseState with _$CreateDbExerciseState {
  const factory CreateDbExerciseState({
    IMap<String, String?>? title,
    @Default(IListConst<String>([])) IList<String> muscleGroupIds,
    String? equipmentId,
    String? recordingTypeId,
    IMap<String, Delta?>? instructions,
    @Default(IListConst<MemoryImageSource>([])) IList<MemoryImageSource> images,
  }) = _CreateDbExerciseState;
}
