import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/views/database_exercises.dart';

class DatabaseExercisesConnector extends StatelessWidget {
  const DatabaseExercisesConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    onInit: (store) => debugPrint('DatabaseExercisesConnector initialized'),
    onDispose: (store) => debugPrint('DatabaseExercisesConnector disposed'),
    vm: () => _Factory(this),
    builder: (context, vm) => const DatabaseExercises(),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, DatabaseExercisesConnector, _Vm> {
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
