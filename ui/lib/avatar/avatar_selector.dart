import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'avatar.dart';

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({required this.source, required this.onTap, super.key});

  final AvatarSource source;
  final VoidCallback onTap;

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  @override
  Widget build(BuildContext context) => Avatar(
    source: widget.source,
    onTap: () async {
      await _pickImage(context);
    },
    size: const Size.fromRadius(32),
  );

  final picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (context.mounted) {
      if (pickedFile != null) {
        ShadToaster.of(context).show(
          ShadToast(
            title: const Text('Image Selected'),
            description: Text('File name: ${pickedFile.name}'),
            action: ShadButton.outline(
              child: const Text('Undo'),
              onPressed: () => ShadToaster.of(context).hide(),
            ),
          ),
        );
      } else {
        ShadToaster.of(context).show(
          ShadToast(
            title: const Text('No Image Selected'),
            description: const Text('Please select an image.  '),
            action: ShadButton.outline(
              child: const Text('Undo'),
              onPressed: () => ShadToaster.of(context).hide(),
            ),
          ),
        );
      }
    }
  }
}
