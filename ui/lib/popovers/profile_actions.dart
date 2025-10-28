import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

import '../tiles/profile_tile.dart';
import 'base_popover.dart';

class ProfileActionsVm extends Equatable {
  const ProfileActionsVm({
    required this.profile,
    required this.onLogOutPressed,
    required this.onEditProfilePressed,
  });

  final ProfileTileVm profile;
  final VoidCallback onLogOutPressed;
  final VoidCallback onEditProfilePressed;

  @override
  List<Object?> get props => [profile, onLogOutPressed];
}

class ProfileActions extends StatelessWidget {
  const ProfileActions({
    required this.vm,
    super.key,
  });

  final ProfileActionsVm vm;

  @override
  Widget build(BuildContext context) => BasePopover(
    alignment: AlignmentDirectional.topStart,
    alignmentOffset: const Offset(33, 0),
    child: (context, controller) => ProfileTile(
      vm: vm.profile,
      onTap: () {
        controller.isOpen ? controller.close() : controller.open();
      },
    ),
    menuChildren: (context, controller) => [
      constrainedMenuButton(
        MenuItemButton(
          onPressed: () {
            controller.close();
            vm.onEditProfilePressed();
          },
          child: Text(S.current.editProfile),
        ),
      ),
      constrainedMenuButton(
        MenuItemButton(
          onPressed: () {
            controller.close();
            vm.onLogOutPressed();
          },
          child: Text(S.current.logOut),
        ),
      ),
    ],
  );
}
