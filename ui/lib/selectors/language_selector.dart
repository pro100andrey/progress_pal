import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/value_changed.dart';

class LanguagePair {
  const LanguagePair(this.locale, this.name);

  final String locale;
  final String name;
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({required this.vm, super.key});

  final ValueChangedWithItemsVm<LanguagePair> vm;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final children = <Widget>[];
    for (final lang in vm.items) {
      final isSelected = vm.value.locale == lang.locale;

      final menuItem = MenuItemButton(
        trailingIcon: Icon(
          isSelected ? LucideIcons.circleCheck : LucideIcons.circle,
          size: 16,
        ),
        onPressed: () {
          if (lang != vm.value) {
            vm.onChangedSync(lang);
          }
        },
        child: Text(lang.name),
      );

      children.add(menuItem);
    }

    return MenuAnchor(
      alignmentOffset: const Offset(-60, 8),
      style: MenuStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(theme.colorScheme.popover),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      menuChildren: children,
      builder: (context, controller, child) => TextButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        child: Text(vm.value.locale.toUpperCase()),
      ),
    );
  }
}
