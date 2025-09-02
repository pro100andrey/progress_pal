import 'package:pocketbase/pocketbase.dart';

import 'language_string.dart';

extension type RecordingType(RecordModel recordingType) implements RecordModel {
  LanguageString get name => recordingType.get<LanguageString>('name');
  String get slug => recordingType.get<String>('slug');
}
