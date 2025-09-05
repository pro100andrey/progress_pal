import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/session/actions/clean_session_action.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/avatar.dart';
import 'package:ui/menus/profile_menu.dart';

import '../../navigation/navigation.dart';

class ProfileMenuConnector extends StatelessWidget {
  const ProfileMenuConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    shouldUpdateModel: selectSessionIsLoggedIn,
    builder: (context, vm) => ProfileActions(
      vm: vm.profileActions,
      // userProfile: const UserProfileSheetConnector(),
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, ProfileMenuConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final avatarUrl = selectSessionCurrentUserAvatarUrl(state);
    final currentUser = selectSessionCurrentUser(state)!;

    return _Vm(
      profileActions: ProfileActionsVm(
        userName: currentUser.name,
        avatar: AvatarSource.network(avatarUrl),
        onEditProfilePressed: () {},
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
  _Vm({
    required this.profileActions,
  });

  final ProfileActionsVm profileActions;

  @override
  List<Object?> get props => [profileActions];
}
