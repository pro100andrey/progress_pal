/// Represents a localized string.
extension type LanguageString(Map<String, dynamic> json) {
  /// Returns the English version of the string.
  String get en => json['en']!;

  /// Returns the Ukrainian version of the string.
  String get ua => json['ua']!;

  /// Get the localized string for the given locale.
  String? get(String locale) => json[locale];

  /// Returns the localized string for the given locale.
  String? operator [](String locale) => get(locale);

  /// Returns user localized string.
  String get $ => json[r'$']!;
}
