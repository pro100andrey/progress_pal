import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    required this.onPressedProgress,
    required this.onPressedWorkouts,
    required this.onPressedExercises,
  });

  final DrawerItem selectedItem;
  final VoidCallback onPressedProgress;
  final VoidCallback onPressedWorkouts;
  final VoidCallback onPressedExercises;

  @override
  List<Object?> get props => [selectedItem];
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    required this.vm,
    required this.profileMenu,
    super.key,
  });

  final AppDrawerVm vm;
  final Widget? profileMenu;

  @override
  Widget build(BuildContext context) => Drawer(
    clipBehavior: Clip.none,
    shape: const RoundedRectangleBorder(),
    width: 280,
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
                final selectionColor = ShadTheme.of(
                  context,
                ).colorScheme.selection;

                final selectedTileColor = selectionColor.withAlpha(10);

                final shape = RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                );

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    ListTile(
                      minTileHeight: 40,
                      selected: vm.selectedItem.isProgress,
                      selectedColor: selectionColor,
                      leading: const Icon(LucideIcons.trendingUp),
                      title: Text(S.current.progress),
                      onTap: vm.onPressedProgress,
                      selectedTileColor: selectedTileColor,
                      shape: shape,
                    ),
                    const SizedBox(height: 2),
                    ListTile(
                      minTileHeight: 40,
                      selected: vm.selectedItem.isWorkouts,
                      selectedColor: selectionColor,
                      leading: const Icon(LucideIcons.bicepsFlexed),
                      title: Text(S.current.workouts),
                      onTap: vm.onPressedWorkouts,
                      selectedTileColor: selectedTileColor,
                      shape: shape,
                    ),
                    const SizedBox(height: 2),
                    ListTile(
                      minTileHeight: 40,
                      selected: vm.selectedItem.isExercises,
                      selectedColor: selectionColor,
                      leading: const Icon(LucideIcons.dumbbell),
                      title: Text(S.current.exercises),
                      onTap: vm.onPressedExercises,
                      selectedTileColor: selectedTileColor,
                      shape: shape,
                    ),
                  ],
                );
              },
            ),
          ),
          if (profileMenu != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: profileMenu,
            ),
        ],
      ),
    ),
  );
}
