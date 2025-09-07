import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'base_placeholder.dart';

class NoMyExercisesPlaceholder extends BasePlaceholder {
  NoMyExercisesPlaceholder({super.key})
    : super(
        icon: LucideIcons.scroll200,
        title: S.current.noExercises,
        subtitle: S.current.youHaveNotCreatedAnyExercisesYet,
      );
}
