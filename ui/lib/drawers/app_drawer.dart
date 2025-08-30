import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../generated/assets.gen.dart';

enum DrawerItem {
  progress,
  workouts,
  exercises;

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
  const AppDrawer({required this.vm, super.key});

  final AppDrawerVm vm;

  @override
  Widget build(BuildContext context) => Drawer(
    clipBehavior: Clip.none,
    shape: const RoundedRectangleBorder(),
    elevation: 0,
    width: 200,
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
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Assets.svg.logo.noBg.svg(width: 28, height: 28),
                Text(
                  S.current.appName,
                  style: ShadTheme.of(context).textTheme.h4,
                ),
              ],
            ),
          ),
          const ShadSeparator.horizontal(thickness: 1, margin: EdgeInsets.zero),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16, top: 16),
              children: [
                ListTile(
                  selected: vm.selectedItem == DrawerItem.progress,
                  selectedColor: Colors.red,
                  leading: const Icon(LucideIcons.trendingUp),
                  title: Text(S.current.progress),
                  onTap: vm.onPressedProgress,
                ),
                ListTile(
                  selected: vm.selectedItem == DrawerItem.workouts,
                  selectedColor: Colors.green,
                  leading: const Icon(LucideIcons.bicepsFlexed),
                  title: Text(S.current.workouts),
                  onTap: vm.onPressedWorkouts,
                ),
                ListTile(
                  selected: vm.selectedItem == DrawerItem.exercises,
                  selectedColor: Colors.blue,
                  leading: const Icon(LucideIcons.dumbbell),
                  title: Text(S.current.exercises),
                  onTap: vm.onPressedExercises,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
