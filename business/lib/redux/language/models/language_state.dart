import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_state.freezed.dart';

enum SupportedLanguage {
  uk,
  en;

  String get code {
    switch (this) {
      case SupportedLanguage.uk:
        return 'uk';
      case SupportedLanguage.en:
        return 'en';
    }
  }
}

@freezed
abstract class LanguageState with _$LanguageState {
  const factory LanguageState({
    @Default(SupportedLanguage.en) SupportedLanguage language,
  }) = _LanguageState;
}
