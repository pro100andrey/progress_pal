import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../models/value_changed.dart';

class ThemeModeIconButton extends StatelessWidget {
  const ThemeModeIconButton({required this.vm, super.key});

  final ValueChangedVm<ThemeMode> vm;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: vm.value.tooltip,
    onPressed: () {
      final newMode = vm.value.toggle();
      vm.onChangedSync(newMode);
    },
    icon: Icon(vm.value.icon),
  );
}

extension ThemeModeIcons on ThemeMode {
  IconData get icon {
    switch (this) {
      case ThemeMode.system:
        return LucideIcons.sunMoon;
      case ThemeMode.light:
        return LucideIcons.sunMedium;
      case ThemeMode.dark:
        return LucideIcons.moon;
    }
  }

  ThemeMode toggle() {
    switch (this) {
      case ThemeMode.system:
        return ThemeMode.light;
      case ThemeMode.light:
        return ThemeMode.dark;
      case ThemeMode.dark:
        return ThemeMode.system;
    }
  }

  String get tooltip {
    switch (this) {
      case ThemeMode.system:
        return S.current.systemMode;
      case ThemeMode.light:
        return S.current.lightMode;
      case ThemeMode.dark:
        return S.current.darkMode;
    }
  }
}
