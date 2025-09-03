import 'package:pocketbase/pocketbase.dart';

import 'language_string.dart';

/// Represents equipment in the system.
extension type Equipment(RecordModel record) implements RecordModel {
  /// Returns the name of the equipment.
  LanguageString get name => record.get<LanguageString>('name');

  /// Returns the slug of the equipment.
  String get slug => record.get<String>('slug');
}
