import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../dev/text_version.dart';
import '../forms/base_form.dart';
import '../image/avatar_selector.dart';
import '../inputs/birthdate_input.dart';
import '../inputs/email_input.dart';
import '../inputs/full_name_input.dart';
import '../models/value_changed.dart';

class EditProfileSheet extends StatelessWidget {
  const EditProfileSheet({
    required this.avatarSelector,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.onPressedSave,
    super.key,
    this.side = ShadSheetSide.right,
  });

  final ShadSheetSide side;
  final AvatarSelectorVm avatarSelector;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final VoidCallback? onPressedSave;

  @override
  Widget build(BuildContext context) => ShadSheet(
    constraints: side == ShadSheetSide.left || side == ShadSheetSide.right
        ? const BoxConstraints(maxWidth: 320)
        : null,
    title: Text(S.current.editProfile),
    description: Text(S.current.editProfileInstructions),
    actionsMainAxisSize: MainAxisSize.max,
    actionsVerticalDirection: VerticalDirection.up,
    child: SingleChildScrollView(
      child: BaseForm(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AvatarSelector(
                vm: avatarSelector,
                size: const Size.fromRadius(50),
              ),
            ),
            FullNameInput(vm: fullName),
            EmailInput(vm: email),
            BirthdateInput(vm: birthdate),
            ShadButton.secondary(
              enabled: onPressedSave != null,
              onPressed: onPressedSave,
              child: Text(S.current.save),
            ),
            const ShadSeparator.horizontal(
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            const TextVersion(),
          ],
        ),
      ),
    ),
  );
}
