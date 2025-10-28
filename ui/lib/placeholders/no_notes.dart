import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'base_placeholder.dart';

class NoNotesPlaceholder extends BasePlaceholder {
  NoNotesPlaceholder({super.key})
    : super(
        icon: LucideIcons.notebookPen100,
        title: S.current.noNotes,
        subtitle: S.current.youDontHaveAnyNotesForThisDay,
      );
}
