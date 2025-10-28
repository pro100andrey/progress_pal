import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'base_placeholder.dart';

class NoBodyStatsPlaceholder extends BasePlaceholder {
  NoBodyStatsPlaceholder({super.key})
    : super(
        icon: LucideIcons.scale100,
        title: S.current.noBodyStats,
        subtitle: S.current.youDontHaveAnyBodyStatsForThisDay,
      );
}
