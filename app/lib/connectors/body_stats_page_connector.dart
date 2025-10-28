import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/models/supported_lagnuage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/pages/body_stats_page.dart';

class BodyStatsPageConnector extends StatelessWidget {
  const BodyStatsPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => BodyStatsPage(
      key: ValueKey(vm.language),
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, BodyStatsPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final language = selectLanguage(state);

    return _Vm(language: language);
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.language,
  });

  final SupportedLanguage language;

  @override
  List<Object?> get props => [language];
}
