import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/exercises_page.dart';
import 'package:ui/tabs/exercises_tabs.dart';

import '../navigation/navigation.dart';

class ExercisesPageConnector extends StatelessWidget {
  const ExercisesPageConnector({
    required this.child,
    required this.tab,
    super.key,
  });

  final Widget child;
  final ExercisesShellTab tab;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    distinct: false,
    vm: () => _Factory(this),
    builder: (context, vm) => ExercisesPage(tabs: vm.tab, child: child),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ExercisesPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() => _Vm(
    tab: ValueChangedVm(
      value: ExerciseTab.values[connector.tab.index],
      onChanged: (value) {
        switch (value) {
          case ExerciseTab.my:
            navigation.goToMyExercises();
          case ExerciseTab.database:
            navigation.goToDatabaseExercises();
        }
      },
    ),
  );
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({required this.tab});

  final ValueChangedVm<ExerciseTab> tab;

  @override
  List<Object?> get props => [tab];
}
