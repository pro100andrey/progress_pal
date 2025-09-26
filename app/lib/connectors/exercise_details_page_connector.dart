import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/pages/exercise_details_page.dart';

class ExerciseDetailsPageConnector extends StatelessWidget {
  const ExerciseDetailsPageConnector({required this.exerciseId, super.key});

  final String exerciseId;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => const ExerciseDetailsPage(),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ExerciseDetailsPageConnector, _Vm> {
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
