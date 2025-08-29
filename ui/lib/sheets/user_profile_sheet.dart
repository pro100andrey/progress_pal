import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../dev/text_version.dart';
import '../forms/base_form.dart';
import '../forms/form_container.dart';
import '../image/avatar_selector.dart';
import '../inputs/birthdate_input.dart';
import '../inputs/email_input.dart';
import '../inputs/full_name.dart';
import '../models/value_changed.dart';

class UserProfileSheet extends StatelessWidget {
  const UserProfileSheet({
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
        ? const BoxConstraints(maxWidth: 420)
        : null,
    title: Text(S.current.editProfile),
    description: Text(S.current.editProfileInstructions),
    actionsMainAxisSize: MainAxisSize.max,
    actionsVerticalDirection: VerticalDirection.up,
    enterDuration: const Duration(milliseconds: 150),
    exitDuration: const Duration(milliseconds: 100),

    child: FormContainer(
      footer: const TextVersion(),
      maxWidth: double.infinity,
      child: BaseForm(
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            AvatarSelector(
              vm: avatarSelector,
              size: const Size.fromRadius(52),
            ),
            FullName(vm: fullName),
            EmailInput(vm: email),
            BirthdateInput(vm: birthdate),
            ShadButton.secondary(
              enabled: onPressedSave != null,
              onPressed: onPressedSave,
              child: Text(S.current.save),
            ),
       
          ],
        ),
      ),
    ),
  );


}
