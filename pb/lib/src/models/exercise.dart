import 'package:pocketbase/pocketbase.dart';

import '../../models.dart';

enum ExerciseStatus {
  draft,
  published,
  archived;

  static ExerciseStatus fromString(String status) {
    switch (status) {
      case 'draft':
        return draft;
      case 'published':
        return published;
      case 'archived':
        return archived;
      default:
        throw ArgumentError('Unknown ExerciseRecordStatus: $status');
    }
  }
}

/// Represents an exercise in the system.
extension type Exercise(RecordModel record) implements RecordModel {
  /// Returns the title of the exercise.
  LanguageString get title => record.get<LanguageString>('title');

  /// Returns the instructions for the exercise.
  LanguageString? get instructions =>
      record.get<LanguageString?>('instructions');

  /// Returns the muscle groups targeted by the exercise.
  List<String> get muscleGroupIds =>
      record.getListValue<String>('muscle_groups');

  /// Returns the equipment required for the exercise.
  String get equipmentId => record.getStringValue('equipment');

  /// Returns the recording type for the exercise.
  RecordingType get recordingType =>
      record.get<RecordingType>('recording_type');

  /// Returns the preview file names of the exercise.
  List<String> get preview => record.getListValue<String>('preview');

  /// Returns the status of the exercise.
  ExerciseStatus get status =>
      ExerciseStatus.fromString(record.getStringValue('status'));

  /// Returns the preview URL paths of the exercise.
  List<String> get previewUrlsPath => preview
      .map((fileName) => '/api/files/$collectionName/${record.id}/$fileName')
      .toList(growable: false);
}
