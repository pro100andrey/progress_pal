import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/equipment/actions/retrieve_equipments_action.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/muscle_groups/actions/retrieve_muscle_groups_action.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:business/redux/my_exercises_view/my_exercises_view_selectors.dart';
import 'package:business/redux/recording_types/actions/retrieve_recording_types_action.dart';
import 'package:business/redux/recording_types/recording_types_selectors.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/drawers/app_drawer.dart';
import 'package:ui/pages/home_page.dart';

import '../navigation/navigation.dart';
import 'drawers/app_drawer_connector.dart';
import 'selectors/language_selector_connector.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({required this.child, required this.tab, super.key});

  final Widget child;
  final HomeShellTab tab;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    shouldUpdateModel: selectSessionIsLoggedIn,
    onInit: (store) async {
      await store.dispatchAndWaitAll([
        RetrieveMuscleGroupsAction(),
        RetrieveEquipmentsAction(),
        RetrieveRecordingTypesAction(),
      ]);
    },
    builder: (context, vm) => HomePage(
      tabTitle: vm.tabTitle,
      dataIsWaiting: vm.dataIsWaiting,
      drawer: AppDrawerConnector(tab: tab),
      languageSelector: const LanguageSelectorConnector(),
      child: child,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, HomePageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final muscleGroupIsWaiting = selectMuscleGroupsIsWaiting(state);
    final myExercisesIsWaiting = selectMyExercisesIsWaiting(state);
    final equipmentIsWaiting = selectEquipmentIsWaiting(state);
    final recordingTypeIsWaiting = selectRecordingTypesIsWaiting(state);

    final dataIsWaiting =
        muscleGroupIsWaiting ||
        equipmentIsWaiting ||
        recordingTypeIsWaiting ||
        myExercisesIsWaiting;

    return _Vm(
      dataIsWaiting: dataIsWaiting,
      tabTitle: DrawerItem.values[connector.tab.index].title,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.dataIsWaiting,
    required this.tabTitle,
  });

  final bool dataIsWaiting;
  final String tabTitle;

  @override
  List<Object?> get props => [dataIsWaiting, tabTitle];
}
