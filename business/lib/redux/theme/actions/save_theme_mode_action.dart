import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

import '../../app_state.dart';

class SaveThemeModeAction extends ReduxAction<AppState> {
  SaveThemeModeAction({required this.mode});

  final ThemeMode mode;

  @override
  Future<AppState> reduce() async {
    await getSettingsStorage.setThemeMode(mode.index);

    return state.copyWith.theme(mode: mode);
  }
}
