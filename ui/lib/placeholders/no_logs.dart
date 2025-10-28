import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'base_placeholder.dart';

class NoLogsPlaceholder extends BasePlaceholder {
  NoLogsPlaceholder({super.key})
    : super(
        icon: LucideIcons.logs100,
        title: S.current.noLogs,
        subtitle: S.current.youDontHaveAnyLogsForThisDay,
      );
}
