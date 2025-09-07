import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'base_placeholder.dart';

class NoBodyStatsPlaceholder extends BasePlaceholder {
  NoBodyStatsPlaceholder({super.key})
    : super(
        icon: LucideIcons.scale200,
        title: S.current.noBodyStats,
        subtitle: S.current.youDontHaveAnyBodyStatsForThisDay,
      );
}
