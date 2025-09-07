import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'base_placeholder.dart';

class NoNotesPlaceholder extends BasePlaceholder {
  NoNotesPlaceholder({super.key})
    : super(
        icon: LucideIcons.notebookPen200,
        title: S.current.noNotes,
        subtitle: S.current.youDontHaveAnyNotesForThisDay,
      );
}
