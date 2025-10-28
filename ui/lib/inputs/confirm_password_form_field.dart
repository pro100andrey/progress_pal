import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'password_input.dart';

class ConfirmPasswordFormField extends PasswordFormField {
  ConfirmPasswordFormField({required super.vm, super.key})
    : super(
        placeholder: S.current.confirmPassword,
        leadingIcon: LucideIcons.check,
      );
}
