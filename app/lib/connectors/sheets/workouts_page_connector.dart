import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/pages/workouts_page.dart';

class WorkoutsPageConnector extends StatelessWidget {
  const WorkoutsPageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => const WorkoutsPage(),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory
    extends VmFactory<AppState, WorkoutsPageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() => _Vm();
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm();

  @override
  List<Object?> get props => [];
}
