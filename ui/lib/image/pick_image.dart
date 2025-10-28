import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/generated/l10n.dart';
import 'package:mime/mime.dart';

import 'editor/image_editor.dart';
import 'model.dart';

Future<void> pickImage({
  required BuildContext context,
  required ImageEditorConfig editorConfig,
  required ValueChanged<MemoryImageVm> onImageSelect,
  Set<String> allowedMimeTypes = const {'image/jpeg', 'image/png'},
}) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (context.mounted) {
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final mime = lookupMimeType(pickedFile.name, headerBytes: bytes);

      if (!allowedMimeTypes.contains(mime) && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text(S.current.unsupportedImageFormat),
                Text(S.current.supportedImageFormats),
              ],
            ),
          ),
        );

        return;
      }

      if (!context.mounted) {
        return;
      }

      final imageEditorKey = GlobalKey<ImageEditorState>();
      
      final resultImage = await showDialog<EditorResult?>(
        context: context,
        barrierDismissible: false,

        builder: (context) => AlertDialog(
          constraints: const BoxConstraints.tightFor(width: 700),
          title: Text(S.current.imageEditor),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.current.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await imageEditorKey.currentState?.exportImage();

                if (context.mounted) {
                  Navigator.of(context).pop(result);
                }
              },
              child: Text(S.current.done),
            ),
          ],
          content: ImageEditor(
            key: imageEditorKey,
            bytes: bytes,
            config: editorConfig,
          ),
        ),
      );

      if (resultImage != null) {
        // Use original file name with new extension
        final name = '${pickedFile.name.split('.').first}.${resultImage.ext}';

        onImageSelect(
          MemoryImageVm(
            bytes: resultImage.bytes,
            name: name,
          ),
        );
      }
    }
  }
}
