import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  const ProfileActions({required this.vm, super.key});
  final ProfileActionsVm vm;

  @override
  Widget build(BuildContext context) => ActionsPopover(
    builder: (context, controller) =>
        ProfileTile(vm: vm.profile, onTap: controller.toggle),
    actionsBuilder: (context, controller) => [
      ShadButton(
        onPressed: () {
          controller.toggle();
          vm.onEditProfilePressed();
        },
        child: Text(S.current.editProfile),
      ),
      ShadButton.destructive(
        onPressed: () {
          controller.toggle();
          vm.onLogOutPressed();
        },
        child: Text(S.current.logOut),
      ),
    ],
  );
}
