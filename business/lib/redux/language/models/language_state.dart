import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/supported_lagnuage.dart';

part 'language_state.freezed.dart';

@freezed
abstract class LanguageState with _$LanguageState {
  const factory LanguageState({
    @Default(SupportedLanguage.en) SupportedLanguage language,
  }) = _LanguageState;
}
