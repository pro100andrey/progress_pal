import 'package:async_redux/async_redux.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';
import '../models/language_state.dart';

class SaveLanguageAction extends ReduxAction<AppState> {
  SaveLanguageAction({required this.locale});

  final String locale;

  @override
  Future<AppState> reduce() async {
    await getSettingsStorage.setLocale(locale);

    return state.copyWith.language(
      language: SupportedLanguage.fromLocale(locale),
    );
  }
}
