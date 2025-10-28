import 'package:flutter/material.dart';

import '../models/language.dart';
import '../models/value_changed.dart';

class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({
    required this.vm,
    this.alignment,
    this.alignmentOffset = Offset.zero,
    this.showFlags = true,
    super.key,
  });

  const LanguageMenuButton.base({
    required this.vm,
    this.alignment,
    this.showFlags = true,
    super.key,
  }) : alignmentOffset = const Offset(-34, 4);

  final ValueChangedWithItemsVm<LanguageVm> vm;
  final AlignmentGeometry? alignment;
  final Offset? alignmentOffset;
  final bool showFlags;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final children = <Widget>[];
    for (final lang in vm.items) {
      final isSelected = vm.value.locale == lang.locale;

      final menuItem = MenuItemButton(
        onPressed: () {
          if (lang != vm.value) {
            vm.onChangedSync(lang);
          }
        },
        child: Text(
          lang.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : null,
          ),
        ),
      );

      children.add(menuItem);
    }

    final borderRadius = BorderRadius.circular(6);

    return MenuAnchor(
      alignmentOffset: alignmentOffset,
      menuChildren: children,
      builder: (context, controller, child) => Align(
        widthFactor: 1,
        heightFactor: 1,
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () =>
                controller.isOpen ? controller.close() : controller.open(),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  if (showFlags) vm.value.flag.svg(height: 12),
                  Text(vm.value.short, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
