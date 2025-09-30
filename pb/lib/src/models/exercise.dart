import 'package:pocketbase/pocketbase.dart';

import '../../models.dart';

/// Represents an exercise in the system.
extension type Exercise(RecordModel record) implements RecordModel {
  /// Returns the title of the exercise.
  LanguageString get title => record.get<LanguageString>('title');

  /// Returns the instructions for the exercise.
  LanguageString? get instructions =>
      record.get<LanguageString?>('instructions');

  /// Returns the muscle group targeted by the exercise.
  List<String> get muscleGroupIds =>
      record.getListValue<String>('muscle_group');

  /// Returns the equipment required for the exercise.
  String get equipmentId => record.getStringValue('equipment');

  /// Returns the recording type for the exercise.
  RecordingType get recordingType =>
      record.get<RecordingType>('recording_type');

  /// Returns the preview file names of the exercise.
  List<String> get preview => record.getListValue<String>('preview');

  /// Returns the preview URL paths of the exercise.
  List<String> get previewUrlsPath => preview
      .map((fileName) => '/api/files/$collectionName/${record.id}/$fileName')
      .toList(growable: false);
}
