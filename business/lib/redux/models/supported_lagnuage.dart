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

  String get short {
    switch (this) {
      case uk:
        return 'UA';
      case en:
        return 'EN';
    }
  }

  String get title {
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
