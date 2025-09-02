import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../image/avatar.dart';

class ProfileMenuVm extends Equatable {
  const ProfileMenuVm({
    required this.userName,
    required this.avatar,
    required this.onPressedLogout,
  });

  final AvatarSource avatar;
  final String userName;
  final VoidCallback onPressedLogout;

  @override
  List<Object?> get props => [avatar, userName];
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.vm,
    required this.userProfile,
    super.key,
  });

  final Widget userProfile;
  final ProfileMenuVm vm;

  @override
  Widget build(BuildContext context) => MenuAnchor(
    style: const MenuStyle(
      alignment: Alignment.center,
    ),
    menuChildren: [
      MenuItemButton(
        leadingIcon: const Icon(LucideIcons.userPen, size: 16),
        onPressed: () => showShadSheet(
          context: context,
          side: ShadSheetSide.right,
          builder: (context) => userProfile,
        ),
        child: Text(S.current.editProfile),
      ),
      MenuItemButton(
        leadingIcon: const Icon(LucideIcons.logOut, size: 16),
        onPressed: () => _onPressedLogout(context),
        child: Text(S.current.logout),
      ),
    ],
    builder: (context, controller, child) => InkWell(
      highlightColor: const Color(0xFF212121),
      onTap: () {
        controller.isOpen ? controller.close() : controller.open();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            Avatar(
              source: vm.avatar,
              size: const Size.fromRadius(16),
            ),
            Text(vm.userName),
          ],
        ),
      ),
    ),
  );

  Future<void> _onPressedLogout(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(S.current.areYouSure),
        description: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(S.current.logoutConfirmation),
        ),
        actions: [
          ShadButton.outline(
            child: Text(S.current.cancel),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ShadButton.destructive(
            child: Text(S.current.logout),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if ((result ?? false) && context.mounted) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      vm.onPressedLogout();
    }
  }
}
