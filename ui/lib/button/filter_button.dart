import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    required this.isIconsMode,
    this.onPressed,
    super.key,
  });

  final bool isIconsMode;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) {
      if (isIconsMode) {
        return IconButton.filled(
          onPressed: onPressed,
          icon: const Icon(Icons.filter_list),
          tooltip: S.current.filter,
        );
      }

      return FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.filter_list),
        label: Text(S.current.filter),
      );
    },
  );
}
