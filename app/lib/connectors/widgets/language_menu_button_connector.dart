import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/language/actions/save_language_action.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/models/supported_lagnuage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/button/language_menu_button.dart';
import 'package:ui/models/language.dart';
import 'package:ui/models/value_changed.dart';

class LanguageMenuButtonConnector extends StatelessWidget {
  const LanguageMenuButtonConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => LanguageMenuButton.base(
      vm: vm.language,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, LanguageMenuButtonConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final language = selectLanguage(state);

    final supportedLanguages = SupportedLanguage.values
        .map(
          (e) => LanguageVm(locale: e.locale, short: e.short, title: e.title),
        )
        .toList(growable: false);
    final currentLanguage = supportedLanguages.firstWhere(
      (element) => element.locale == language.locale,
    );

    return _Vm(
      language: ValueChangedWithItemsVm(
        value: currentLanguage,
        items: supportedLanguages,
        onChanged: (pair) => dispatch(SaveLanguageAction(locale: pair.locale)),
      ),
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.language,
  });

  final ValueChangedWithItemsVm<LanguageVm> language;

  @override
  List<Object?> get props => [language];
}
