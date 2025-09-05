import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_state.freezed.dart';

enum SupportedLanguage {
  uk,
  en;

  String get locale {
    switch (this) {
      case uk:
        return 'uk';
      case en:
        return 'en';
    }
  }

  String get name {
    switch (this) {
      case uk:
        return 'Українська';
      case en:
        return 'English';
    }
  }

  static List<String> get locales =>
      values.map((e) => e.locale).toList(growable: false);

  static SupportedLanguage fromLocale(String locale) =>
      SupportedLanguage.values.firstWhere(
        (element) => element.locale == locale,
        orElse: () => throw Exception('Unsupported language locale: $locale'),
      );
}

@freezed
abstract class LanguageState with _$LanguageState {
  const factory LanguageState({
    @Default(SupportedLanguage.en) SupportedLanguage language,
  }) = _LanguageState;
}
