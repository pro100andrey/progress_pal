import 'package:async_redux/async_redux.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';
import '../../models/supported_lagnuage.dart';

class LoadLanguageAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final locale = await getSettingsStorage.getLocale();

    if (locale == null) {
      return null;
    }

    return state.copyWith.language(
      language: SupportedLanguage.fromLocale(locale),
    );
  }
}
