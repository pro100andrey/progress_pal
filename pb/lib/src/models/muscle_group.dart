import 'package:pocketbase/pocketbase.dart';

import 'language_string.dart';

/// Represents a muscle group.
extension type MuscleGroup(RecordModel record) implements RecordModel {
  /// Returns the name of the muscle group.
  LanguageString get name => record.get<LanguageString>('name');

  /// Returns the slug of the muscle group.
  String get slug => record.get<String>('slug');
}
