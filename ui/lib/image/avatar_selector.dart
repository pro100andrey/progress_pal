import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'avatar.dart';
import 'editor/circle_editor_crop_layer_painter.dart';
import 'editor/image_editor.dart';

class AvatarSelectorVm extends Equatable {
  const AvatarSelectorVm({
    required this.src,

    required this.onImageSelect,
  });

  final AvatarSource src;
  final ValueChanged<({Uint8List bytes, String name})?> onImageSelect;

  @override
  List<Object?> get props => [src, onImageSelect];
}

class AvatarSelector extends StatefulWidget {
  const AvatarSelector({
    required this.vm,
    this.size = const Size.fromRadius(42),
    super.key,
  });

  final AvatarSelectorVm vm;
  final Size size;

  @override
  State<AvatarSelector> createState() => _AvatarSelectorState();
}

class _AvatarSelectorState extends State<AvatarSelector> {
  final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ShadPopover(
    controller: popoverController,
    child: Avatar(
      source: widget.vm.src,
      onTap: () async => _handleTap(context),
      size: widget.size,
    ),
    popover: (context) => SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          ShadButton.destructive(
            onPressed: () {
              popoverController.hide();
              widget.vm.onImageSelect(null);
            },
            child: Text(S.current.delete),
          ),
          ShadButton.secondary(
            onPressed: () async {
              popoverController.hide();
              await _pickImage(context);
            },
            child: Text(S.current.selectAnotherImage),
          ),
        ],
      ),
    ),
  );

  final _picker = ImagePicker();

  Future<void> _handleTap(BuildContext context) async {
    if (widget.vm.src.isEmpty) {
      await _pickImage(context);
    } else {
      popoverController.toggle();
    }
  }

  Future<void> _pickImage(
    BuildContext context, [
    Set<String> allowedExtension = const {'jpg', 'jpeg', 'png'},
  ]) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (context.mounted) {
      if (pickedFile != null) {
        final name = pickedFile.name;
        final ext = name.split('.').last.toLowerCase();
        if (!allowedExtension.contains(ext) && context.mounted) {
          ShadToaster.of(context).show(
            ShadToast(
              title: Text(S.current.unsupportedImageFormat),
              description: Text(S.current.supportedImageFormats),
            ),
          );
          
          return;
        }

        final bytes = await pickedFile.readAsBytes();

        if (!context.mounted) {
          return;
        }

        final resultImage = await showShadDialog<Uint8List?>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ShadDialog(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
                maxHeight: 500,
              ),
              child: ImageEditor(
                bytes: bytes,
                cropLayerPainter: const CircleEditorCropLayerPainter(),
                maxSize: const Size(128, 128),
              ),
            ),
          ),
        );

        if (resultImage != null) {
          widget.vm.onImageSelect((
            bytes: resultImage,
            name: name,
          ));
        }
      }
    }
  }
}
