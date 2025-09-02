import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_view_state.freezed.dart';

@freezed
abstract class ProgressViewState with _$ProgressViewState {
  const factory ProgressViewState({
    DateTime? selectedDate,
  }) = _ProgressViewState;
}
