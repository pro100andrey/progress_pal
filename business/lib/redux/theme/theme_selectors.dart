import 'package:flutter/material.dart';

import '../app_state.dart';

/// Returns the current theme mode of the app.
ThemeMode selectThemeMode(AppState state) => state.theme.mode;
