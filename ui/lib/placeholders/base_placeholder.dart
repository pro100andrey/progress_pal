import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BasePlaceholder extends StatelessWidget {
  const BasePlaceholder({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize = 68,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final double iconSize;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Icon(icon, size: iconSize),
        Text(
          title,
          style: ShadTheme.of(context).textTheme.h4,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: ShadTheme.of(context).textTheme.lead.copyWith(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
