import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/avatar.dart';
import 'package:ui/pages/home_page.dart';

import 'sheets/user_profile_sheet_connector.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => HomePage(
      isWaiting: vm.isWaiting,
      avatar: vm.avatar,
      userProfile: const UserProfileSheetConnector(),
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, HomePageConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() => _Vm(
    isWaiting: false,
    avatar: const AvatarSource.network((
      name: null,
      url: 'https://avatars.githubusercontent.com/u/2468119?v=4',
    )),
  );
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.isWaiting,
    required this.avatar,
  });

  final bool isWaiting;
  final AvatarSource avatar;

  @override
  List<Object?> get props => [isWaiting, avatar];
}
