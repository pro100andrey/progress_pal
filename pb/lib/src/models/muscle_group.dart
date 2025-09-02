import 'package:pocketbase/pocketbase.dart';

import 'language_string.dart';

extension type MuscleGroup(RecordModel muscleGroup) implements RecordModel {
  LanguageString get name => muscleGroup.get<LanguageString>('name');
  String get slug => muscleGroup.get<String>('slug');
}
