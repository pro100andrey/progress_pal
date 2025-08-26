import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    required this.onPressedLogout,
    super.key,
    this.side = ShadSheetSide.right,
  });

  final ShadSheetSide side;
  final AvatarSelectorVm avatarSelector;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final VoidCallback? onPressedSave;
  final VoidCallback onPressedLogout;

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
    actions: [
      ShadButton.destructive(
        width: 150,
        child: Text(S.current.logout),
        onPressed: () => _onPressedLogout(context),
      ),
    ],
    child: FormContainer(
      maxWidth: double.infinity,
      child: BaseForm(
        builder: (state) => Column(
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

  Future<void> _onPressedLogout(BuildContext context) async {
    final result = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(S.current.areYouSure),
        description: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(S.current.logoutConfirmation),
        ),
        actions: [
          ShadButton.outline(
            child: Text(S.current.cancel),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ShadButton.destructive(
            child: Text(S.current.logout),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if ((result ?? false) && context.mounted) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      onPressedLogout();
    }
  }
}
