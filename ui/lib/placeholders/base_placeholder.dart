import 'package:flutter/widgets.dart';

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
        Text(title),
        Text(subtitle, textAlign: TextAlign.center),
      ],
    ),
  );
}
