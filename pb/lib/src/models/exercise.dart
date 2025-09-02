import 'package:pocketbase/pocketbase.dart';

import '../../models.dart';

extension type Exercise(RecordModel exercise) implements RecordModel {
  LanguageString get title => exercise.get<LanguageString>('title');
  LanguageString? get instructions =>
      exercise.get<LanguageString?>('instructions');
  MuscleGroup get muscleGroup => exercise.get<MuscleGroup>('muscle_group');
  Equipment get equipment => exercise.get<Equipment>('equipment');
  RecordingType get recordingType =>
      exercise.get<RecordingType>('recording_type');
}
