import '../app_state.dart';
import 'models/language_state.dart';

/// Returns the current language.
SupportedLanguage selectLanguage(AppState state) =>
    state.language.language;
