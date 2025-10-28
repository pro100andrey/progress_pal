import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../indicators/base_circle_indicator.dart';

class MyExerciseActionsVm extends Equatable {
  const MyExerciseActionsVm({
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.isDeleting,
  });
  final bool isDeleting;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  @override
  List<Object?> get props => [
    isDeleting,
    onEditPressed != null,
    onDeletePressed != null,
  ];
}

class MyExerciseActions extends StatelessWidget {
  const MyExerciseActions({
    required this.vm,
    super.key,
  });

  final MyExerciseActionsVm vm;

  @override
  Widget build(BuildContext context) => vm.isDeleting
      ? const BaseCircleIndicator()
      : MenuAnchor(
          alignmentOffset: const Offset(-36, 4),
          style: const MenuStyle(
            alignment: Alignment.bottomLeft,
          ),
          menuChildren: [
            MenuItemButton(
              leadingIcon: const Icon(LucideIcons.pen, size: 16),
              onPressed: vm.onEditPressed,
              child: Text(S.current.edit),
            ),
            MenuItemButton(
              leadingIcon: const Icon(LucideIcons.trash, size: 16),
              onPressed: vm.onDeletePressed,
              child: Text(S.current.delete),
            ),
          ],
          builder: (context, controller, child) => OutlinedButton(
            child: const Icon(LucideIcons.ellipsisVertical),
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
          ),
        );
}
