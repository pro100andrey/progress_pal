import 'package:business/redux/models/supported_lagnuage.dart';
import 'package:ui/models/language.dart';

final mapSupportedLanguages = SupportedLanguage.values
    .map(
      (e) => LanguageVm(
        locale: e.locale,
        short: e.short,
        title: e.title,
      ),
    )
    .toList(growable: false);
