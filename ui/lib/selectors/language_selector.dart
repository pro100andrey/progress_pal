import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../generated/assets.gen.dart';
import '../models/value_changed.dart';

class LanguageVm extends Equatable {
  const LanguageVm({
    required this.locale,
    required this.short,
    required this.title,
  });

  final String locale;
  final String short;
  final String title;

  SvgGenImage get flag => switch (locale) {
    'uk' => Assets.flags.ua,
    'en' => Assets.flags.gb,
    _ => throw Exception('Unsupported language locale: $locale'),
  };

  @override
  List<Object?> get props => [locale, short, title];
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({required this.vm, super.key});

  final ValueChangedWithItemsVm<LanguageVm> vm;

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
        child: Text(lang.title),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            vm.value.flag.svg(width: 12, height: 12),
            Text(vm.value.short),
          ],
        ),
      ),
    );
  }
}
