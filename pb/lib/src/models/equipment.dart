import 'package:pocketbase/pocketbase.dart';

import 'language_string.dart';

extension type Equipment(RecordModel equipment) implements RecordModel {
  LanguageString get name => equipment.get<LanguageString>('name');
  String get slug => equipment.get<String>('slug');
}
