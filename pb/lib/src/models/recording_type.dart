import 'package:pocketbase/pocketbase.dart';

import 'language_string.dart';

/// Represents a recording type.
extension type RecordingType(RecordModel record) implements RecordModel {
  /// Returns the name of the recording type.
  LanguageString get name => record.get<LanguageString>('name');

  /// Returns the slug of the recording type.
  String get slug => record.get<String>('slug');
}
