import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/theme/actions/save_theme_mode_action.dart';
import 'package:business/redux/theme/theme_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/button/theme_mode_icon_button.dart';
import 'package:ui/models/value_changed.dart';

class ThemeModeIconButtonConnector extends StatelessWidget {
  const ThemeModeIconButtonConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => ThemeModeIconButton(vm: vm.themeMode),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ThemeModeIconButtonConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final themeMode = selectThemeMode(state);
    return _Vm(
      themeMode: ValueChangedVm(
        value: themeMode,
        onChanged: (value) async =>
            dispatchAndWait(SaveThemeModeAction(mode: value)),
      ),
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({required this.themeMode});

  final ValueChangedVm<ThemeMode> themeMode;

  @override
  List<Object?> get props => [themeMode];
}
