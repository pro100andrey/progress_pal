extension type LanguageString(Map<String, dynamic> json) {
  String get en => json['en']!;
  String get ua => json['ua']!;
  /// Get the localized string for the given locale.
  String? get(String locale) => json[locale];

  String? operator [](String locale) => get(locale);

  String get user => json['user']!;
}
