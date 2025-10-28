import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../placeholders/no_body_stats.dart';

class BodyStatsPage extends StatelessWidget {
  const BodyStatsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    floatingActionButton: FloatingActionButton.small(
      tooltip: S.current.addBodyStat,
      onPressed: () {},
      child: const Icon(LucideIcons.plus),
    ),
    body: Stack(
      children: [
        Center(child: NoBodyStatsPlaceholder()),
      ],
    ),
  );
}
