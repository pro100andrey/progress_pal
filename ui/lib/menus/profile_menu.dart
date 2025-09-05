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
        child: Text(S.current.logOut),
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
            child: Text(S.current.logOut),
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

typedef BasePopoverChildBuilder =
    Widget Function(BuildContext context, ShadPopoverController controller);

class BasePopover extends StatefulWidget {
  const BasePopover({
    required this.builder,
    required this.popover,
    this.constraints = const BoxConstraints(),
    this.anchor,
    this.padding,
    super.key,
  });

  final BoxConstraints constraints;
  final BasePopoverChildBuilder builder;
  final WidgetBuilder popover;
  final ShadAnchorBase? anchor;
  final EdgeInsetsGeometry? padding;

  @override
  State<BasePopover> createState() => _BasePopoverState();
}

class _BasePopoverState extends State<BasePopover> {
  final _controller = ShadPopoverController();

  @override
  Widget build(BuildContext context) => ShadPopover(
    padding: widget.padding,
    anchor: widget.anchor,
    controller: _controller,
    popover: (context) => ConstrainedBox(
      constraints: widget.constraints,
      child: widget.popover(context),
    ),
    child: widget.builder(context, _controller),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ProfileActionsVm extends Equatable {
  const ProfileActionsVm({
    required this.userName,
    required this.avatar,
    required this.onEditProfilePressed,
    required this.onLogOutPressed,
  });

  final AvatarSource avatar;
  final String userName;
  final VoidCallback onEditProfilePressed;
  final VoidCallback onLogOutPressed;

  @override
  List<Object?> get props => [avatar, userName];
}

final class ProfileActions extends BasePopover {
  ProfileActions({required this.vm, super.key})
    : super(
        anchor: const ShadAnchorAuto(
          targetAnchor: Alignment.topCenter,
        ),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(maxWidth: 200),
        builder: (context, controller) => InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: controller.toggle,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              spacing: 8,
              children: [
                Avatar(
                  source: vm.avatar,
                  size: const Size.fromRadius(16),
                ),
                Flexible(child: Text(vm.userName)),
              ],
            ),
          ),
        ),
        popover: (context) {
          final theme = ShadTheme.of(context);

          return Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ShadButton.outline(
                child: Text(S.current.editProfile),
                onPressed: () {},
              ),
              ShadButton.outline(
                foregroundColor: theme.colorScheme.selection,
                child: Text(S.current.logOut),
                onPressed: () {},
              ),
            ],
          );
        },
      );

  final ProfileActionsVm vm;
}
