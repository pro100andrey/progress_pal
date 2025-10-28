import '../app_state.dart';
import '../models/supported_lagnuage.dart';

/// Returns the current language.
SupportedLanguage selectLanguage(AppState state) => state.language.language;
