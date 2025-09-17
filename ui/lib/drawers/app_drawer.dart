import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../popovers/profile_actions.dart';
import '../tiles/profile_tile.dart';

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

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    required this.vm,
    required this.editProfile,
    super.key,
  });

  final AppDrawerVm vm;
  final Widget editProfile;

  @override
  Widget build(BuildContext context) => Drawer(
    clipBehavior: Clip.none,
    shape: const RoundedRectangleBorder(),
    width: 240,
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: ShadTheme.of(context).colorScheme.border,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.ghost(
                  padding: EdgeInsets.zero,
                  width: 26,
                  height: 26,
                  onPressed: () {},
                  child: const Icon(LucideIcons.panelLeftClose200, size: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final theme = ShadTheme.of(context);

                final selectedTileColor = theme.colorScheme.selection.withAlpha(
                  10,
                );

                final shape = RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                );

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    ListTile(
                      minTileHeight: 40,
                      selected: vm.selectedItem.isProgress,
                      selectedColor: theme.colorScheme.selection,
                      leading: const Icon(LucideIcons.trendingUp),
                      title: Text(S.current.progress),
                      onTap: vm.onProgressPressed,
                      selectedTileColor: selectedTileColor,
                      shape: shape,
                    ),
                    const SizedBox(height: 2),
                    ListTile(
                      minTileHeight: 40,
                      selected: vm.selectedItem.isWorkouts,
                      selectedColor: theme.colorScheme.selection,
                      leading: const Icon(LucideIcons.bicepsFlexed),
                      title: Text(S.current.workouts),
                      onTap: vm.onWorkoutsPressed,
                      selectedTileColor: selectedTileColor,
                      shape: shape,
                    ),
                    const SizedBox(height: 2),
                    ListTile(
                      minTileHeight: 40,
                      selected: vm.selectedItem.isExercises,
                      selectedColor: theme.colorScheme.selection,
                      leading: const Icon(LucideIcons.dumbbell),
                      title: Text(S.current.exercises),
                      onTap: vm.onExercisesPressed,
                      selectedTileColor: selectedTileColor,
                      shape: shape,
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ProfileActions(
              vm: ProfileActionsVm(
                profile: vm.profile,
                onLogOutPressed: () => _onLogOutPressed(context),
                onEditProfilePressed: () => showDialog(
                  context: context,
                  builder: (context) => ShadSheetInheritedWidget(
                    side: ShadSheetSide.right,
                    child: editProfile,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _onLogOutPressed(BuildContext context) async {
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

      vm.onLogOutPressed();
    }
  }
}
