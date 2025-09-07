import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'base_placeholder.dart';

class NoLogsPlaceholder extends BasePlaceholder {
  NoLogsPlaceholder({super.key})
    : super(
        icon: LucideIcons.logs200,
        title: S.current.noLogs,
        subtitle: S.current.youDontHaveAnyLogsForThisDay,
      );
}
