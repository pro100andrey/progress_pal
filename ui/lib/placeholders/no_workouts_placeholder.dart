import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'base_placeholder.dart';

class NoWorkoutsPlaceholder extends BasePlaceholder {
  NoWorkoutsPlaceholder({super.key})
    : super(
        icon: LucideIcons.dumbbell100,
        title: S.current.noWorkouts,
        subtitle: S.current.createAWorkoutToGetStarted,
      );
}
