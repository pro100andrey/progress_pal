import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';

class LoadThemeModeAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final themeMode = await getSettingsStorage.getThemeMode();

    if (themeMode == null) {
      return state.copyWith.theme(mode: ThemeMode.system);
    }

    return state.copyWith.theme(
      mode: ThemeMode.values[themeMode],
    );
  }
}
