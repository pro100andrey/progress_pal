import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_my_exercise_state.freezed.dart';

@freezed
abstract class EditMyExerciseState with _$EditMyExerciseState {
  const factory EditMyExerciseState({String? value}) = _EditMyExerciseState;
}
