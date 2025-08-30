import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/drawers/app_drawer.dart';
import 'package:ui/pages/home_page.dart';

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
    builder: (context, vm) => HomePage(
      isWaiting: vm.isWaiting,
      profileMenu: const ProfileMenuConnector(),
      appDrawer: vm.appDrawer,
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

    return _Vm(
      isWaiting: currentUser == null,
      appDrawer: AppDrawerVm(
        selectedItem: DrawerItem.values[connector.tab.index],
        onPressedProgress: navigation.goToProgress,
        onPressedWorkouts: navigation.goToWorkouts,
        onPressedExercises: navigation.goToExercises,
      ),
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.isWaiting,
    required this.appDrawer,
  });

  final bool isWaiting;
  final AppDrawerVm appDrawer;

  @override
  List<Object?> get props => [isWaiting, appDrawer];
}
