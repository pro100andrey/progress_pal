import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../dev/text_version.dart';
import '../forms/base_form.dart';
import '../image/editor/image_editor.dart';
import '../image/image_selector.dart';
import '../image/model.dart';
import '../inputs/birthdate_form_filed.dart';
import '../inputs/email_form_field.dart';
import '../inputs/full_name_form_field.dart';
import '../models/value_changed.dart';

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({
    required this.avatarSelector,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.isAdmin,
    required this.isWriter,
    required this.onPressedSave,
    super.key,
  });

  final ImageSelectorVm avatarSelector;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final bool isAdmin;
  final bool isWriter;
  final VoidCallback? onPressedSave;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(S.current.editProfile),
    actions: [
      TextButton(
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
        child: Text(S.current.cancel),
      ),
      ElevatedButton(
        onPressed: onPressedSave,
        child: Text(S.current.save),
      ),
    ],
    content: BaseForm(
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          ImageSelector.avatar(
            vm: avatarSelector,
            sizeRadius: ImageVm.maxAvatarRadius,
            placeholderIconSize: ImageVm.maxAvatarRadius,
            cacheSize: ImageVm.maxAvatarSize,
            editorConfig: ImageEditorConfig.circle(
              maxImageSize: ImageVm.maxAvatarSize,
            ),
          ),
          FullNameFormFiled(vm: fullName),
          EmailFormFiled(vm: email),
          BirthdateFormFiled(vm: birthdate),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (isAdmin)
                const Icon(
                  LucideIcons.shieldUser,
                  size: 16,
                  color: Colors.amber,
                ),
              if (isWriter)
                const Icon(
                  LucideIcons.userPen,
                  size: 16,
                  color: Colors.cyanAccent,
                ),
              const TextVersion(),
            ],
          ),
        ],
      ),
    ),
  );
}
