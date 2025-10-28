import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_db_exercise_state.freezed.dart';

@freezed
abstract class EditDbExerciseState with _$EditDbExerciseState {
  const factory EditDbExerciseState({String? value}) = _EditDbExerciseState;
}
