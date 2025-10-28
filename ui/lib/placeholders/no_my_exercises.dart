import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'base_placeholder.dart';

class NoMyExercisesPlaceholder extends BasePlaceholder {
  NoMyExercisesPlaceholder({super.key})
    : super(
        icon: LucideIcons.scroll100,
        title: S.current.noExercises,
        subtitle: S.current.youHaveNotCreatedAnyExercisesYet,
      );
}
