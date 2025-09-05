import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/equipment/actions/retrieve_equipments_action.dart';
import 'package:business/redux/equipment/equipments_selectors.dart';
import 'package:business/redux/language/actions/save_language_action.dart';
import 'package:business/redux/language/language_selectors.dart';
import 'package:business/redux/language/models/language_state.dart';
import 'package:business/redux/muscle_groups/actions/retrieve_muscle_groups_action.dart';
import 'package:business/redux/muscle_groups/muscle_groups_selectors.dart';
import 'package:business/redux/my_exercises_view/my_exercises_view_selectors.dart';
import 'package:business/redux/recording_types/actions/retrieve_recording_types_action.dart';
import 'package:business/redux/recording_types/recording_types_selectors.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/drawers/app_drawer.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/pages/home_page.dart';
import 'package:ui/selectors/language_selector.dart';

import '../navigation/navigation.dart';
import 'menu/profile_menu_connector.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({required this.child, required this.tab, super.key});

  final Widget child;
  final HomeShellTab tab;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    onInit: (store) async {
      await store.dispatchAndWaitAll([
        RetrieveMuscleGroupsAction(),
        RetrieveEquipmentsAction(),
        RetrieveRecordingTypesAction(),
      ]);
    },
    builder: (context, vm) => HomePage(
      userIsWaiting: vm.userIsWaiting,
      dataIsWaiting: vm.dataIsWaiting,
      profileMenu: const ProfileMenuConnector(),
      appDrawer: vm.appDrawer,
      language: vm.language,
      child: child,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, HomePageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final currentUser = selectSessionCurrentUser(state);
    final muscleGroupIsWaiting = selectMuscleGroupsIsWaiting(state);
    final myExercisesIsWaiting = selectMyExercisesIsWaiting(state);
    final equipmentIsWaiting = selectEquipmentIsWaiting(state);
    final recordingTypeIsWaiting = selectRecordingTypesIsWaiting(state);
    final language = selectLanguage(state);

    final dataIsWaiting =
        muscleGroupIsWaiting ||
        equipmentIsWaiting ||
        recordingTypeIsWaiting ||
        myExercisesIsWaiting;

    return _Vm(
      userIsWaiting: currentUser == null,
      dataIsWaiting: dataIsWaiting,
      appDrawer: AppDrawerVm(
        selectedItem: DrawerItem.values[connector.tab.index],
        onPressedProgress: navigation.goToProgress,
        onPressedWorkouts: navigation.goToWorkouts,
        onPressedExercises: navigation.goToExercises,
      ),
      language: ValueChangedWithItemsVm(
        value: LanguagePair(language.locale, language.name),
        items: SupportedLanguage.values
            .map((e) => LanguagePair(e.locale, e.name))
            .toList(),
        onChanged: (pair) => dispatch(SaveLanguageAction(locale: pair.locale)),
      ),
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.userIsWaiting,
    required this.dataIsWaiting,
    required this.appDrawer,
    required this.language,
  });

  final bool userIsWaiting;
  final bool dataIsWaiting;
  final AppDrawerVm appDrawer;
  final ValueChangedWithItemsVm<LanguagePair> language;

  @override
  List<Object?> get props => [
    userIsWaiting,
    dataIsWaiting,
    appDrawer,
    language,
  ];
}
