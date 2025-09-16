import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/session/actions/clean_session_action.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/drawers/app_drawer.dart';
import 'package:ui/image/avatar.dart';
import 'package:ui/tiles/profile_tile.dart';

import '../../navigation/navigation.dart';
import '../sheets/edit_profile_sheet_connector.dart';

class AppDrawerConnector extends StatelessWidget {
  const AppDrawerConnector({required this.tab, super.key});

  final HomeShellTab tab;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => AppDrawer(
      vm: vm.appDrawer,
      editProfile: const UserProfileSheetConnector(),
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, AppDrawerConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final currentUser = selectSessionCurrentUser(state)!;
    final avatarUrl = selectSessionCurrentUserAvatarUrl(state);

    return _Vm(
      appDrawer: AppDrawerVm(
        profile: ProfileTileVm(
          userName: currentUser.name,
          avatar: AvatarSource.network(avatarUrl),
        ),
        selectedItem: DrawerItem.values[connector.tab.index],
        onProgressPressed: navigation.goToProgress,
        onWorkoutsPressed: navigation.goToWorkouts,
        onExercisesPressed: navigation.goToExercises,
        onLogOutPressed: () {
          dispatchSync(CleanSessionAction());
          navigation.refresh();
        },
      ),
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({required this.appDrawer});

  final AppDrawerVm appDrawer;

  @override
  List<Object?> get props => [appDrawer];
}
