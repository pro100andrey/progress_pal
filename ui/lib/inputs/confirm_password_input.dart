import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'password_input.dart';

class ConfirmPasswordInput extends PasswordInput {
  ConfirmPasswordInput({required super.vm, super.key})
    : super(
        id: 'confirm_password',
        placeholder: S.current.confirmPassword,
        leadingIcon: LucideIcons.check100,
      );
}
