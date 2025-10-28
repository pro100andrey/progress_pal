import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../indicators/base_circle_indicator.dart';
import '../popovers/profile_actions.dart';
import '../responsive/responsive_scaffold.dart';
import '../tiles/profile_tile.dart';
import '../ui.dart';

enum DrawerItem {
  progress,
  workouts,
  exercises;

  bool get isProgress => this == progress;
  bool get isWorkouts => this == workouts;
  bool get isExercises => this == exercises;

  String get title {
    switch (this) {
      case progress:
        return S.current.progress;
      case workouts:
        return S.current.workouts;
      case exercises:
        return S.current.exercises;
    }
  }

  IconData get icon {
    switch (this) {
      case progress:
        return LucideIcons.trendingUp;
      case workouts:
        return LucideIcons.bicepsFlexed;
      case exercises:
        return LucideIcons.dumbbell;
    }
  }
}

class AppDrawerVm extends Equatable {
  const AppDrawerVm({
    required this.selectedItem,
    required this.profile,
    required this.onProgressPressed,
    required this.onWorkoutsPressed,
    required this.onExercisesPressed,
    required this.onLogOutPressed,
  });

  final DrawerItem selectedItem;
  final ProfileTileVm profile;
  final VoidCallback onProgressPressed;
  final VoidCallback onWorkoutsPressed;
  final VoidCallback onExercisesPressed;
  final VoidCallback onLogOutPressed;

  @override
  List<Object?> get props => [selectedItem, profile];
}

class HomePage extends StatefulWidget {
  const HomePage({
    required this.dataIsWaiting,
    required this.child,
    required this.drawer,
    required this.editProfileDialog,
    required this.themeModeIconButton,
    required this.languageMenuButton,
    super.key,
  });

  final AppDrawerVm drawer;
  final bool dataIsWaiting;
  final Widget child;
  final Widget editProfileDialog;
  final Widget themeModeIconButton;
  final Widget languageMenuButton;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => ResponsiveScaffold(
    menuWidth: UI.menuWidth,
    extendBody: true,
    railWidth: UI.railWidth(context),
    desktopWidthBreakpoint: UI.desktopWidthBreakpoint,
    phoneWidthBreakpoint: UI.phoneWidthBreakpoint,
    selectedIndex: widget.drawer.selectedItem.index,
    onSelect: (index) {
      switch (DrawerItem.values[index]) {
        case DrawerItem.progress:
          widget.drawer.onProgressPressed();
        case DrawerItem.workouts:
          widget.drawer.onWorkoutsPressed();
        case DrawerItem.exercises:
          widget.drawer.onExercisesPressed();
      }
    },
    title: Text(widget.drawer.selectedItem.title),
    footer: (context, menuState) => menuState == MenuState.none
        ? null
        : ProfileActions(
            vm: ProfileActionsVm(
              profile: widget.drawer.profile,
              onLogOutPressed: () => _onLogOutPressed(context),
              onEditProfilePressed: () => showDialog(
                context: context,
                builder: (context) => widget.editProfileDialog,
              ),
            ),
          ),
    menuTitle: Text(S.current.appName),
    actions: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.dataIsWaiting) const BaseCircleIndicator(),
          widget.languageMenuButton,
          widget.themeModeIconButton,
        ],
      ),
    ],
    menuItems: [
      ...DrawerItem.values.map(
        (item) => ResponsiveMenuItems(
          selected: widget.drawer.selectedItem == item,
          label: item.title,
          tooltip: item.title,
          icon: item.icon,
          iconSecondary: LucideIcons.check,
        ),
      ),
    ],
    body: widget.child,
  );

  Future<void> _onLogOutPressed(BuildContext context) async {
    final theme = Theme.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.areYouSure),
            Text(
              S.current.logoutConfirmation,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(S.current.cancel),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
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

      widget.drawer.onLogOutPressed();
    }
  }
}
