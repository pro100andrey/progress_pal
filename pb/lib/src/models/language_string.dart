/// Represents a localized string.
extension type LanguageString(Map<String, dynamic> json) {
  /// Get the localized string for the given locale.
  String? getString(String locale) => json[locale];

  List<Map<String, dynamic>> getDelta(String locale) {
    final deltaJson = json[locale] as List;

    return deltaJson.cast();
  }

  /// Returns user localized string.
  String get $ => json[r'$']!;
}
