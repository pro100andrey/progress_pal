import 'package:pocketbase/pocketbase.dart';

import '../../models.dart';

/// Represents an exercise in the system.
extension type Exercise(RecordModel exercise) implements RecordModel {
  /// Returns the title of the exercise.
  LanguageString get title => exercise.get<LanguageString>('title');

  /// Returns the instructions for the exercise.
  LanguageString? get instructions =>
      exercise.get<LanguageString?>('instructions');

  /// Returns the muscle group targeted by the exercise.
  List<MuscleGroup> get muscleGroup =>
      exercise.getListValue<MuscleGroup>('muscle_group');

  /// Returns the equipment required for the exercise.
  Equipment get equipment => exercise.get<Equipment>('equipment');

  /// Returns the recording type for the exercise.
  RecordingType get recordingType =>
      exercise.get<RecordingType>('recording_type');
}
