import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../popovers/base_popover.dart';
import 'editor/image_editor.dart';
import 'image_preview.dart';
import 'model.dart';
import 'pick_image.dart';

class ImageSelectorVm extends Equatable {
  const ImageSelectorVm({
    required this.image,
    required this.onImageSelect,
  });

  final ImageVm image;
  final ValueChanged<MemoryImageVm?> onImageSelect;

  @override
  List<Object?> get props => [image, onImageSelect];
}

class ImageSelector extends StatefulWidget {
  const ImageSelector({
    required this.vm,
    required this.editorConfig,
    required this.placeholder,
    this.size = const Size.fromRadius(42),
    this.shape = BoxShape.rectangle,
    this.fit = BoxFit.cover,
    this.cacheSize,
    this.border,
    this.borderRadius,
    super.key,
  });

  ImageSelector.avatar({
    required this.vm,
    required this.editorConfig,
    this.cacheSize,
    this.border,
    double sizeRadius = 16,
    double placeholderIconSize = 16,
    super.key,
  }) : placeholder = Icon(LucideIcons.user, size: placeholderIconSize),
       size = Size.fromRadius(sizeRadius),
       shape = BoxShape.circle,
       fit = BoxFit.cover,
       borderRadius = BorderRadius.circular(sizeRadius);

  final ImageSelectorVm vm;
  final Widget placeholder;
  final Size size;
  final Size? cacheSize;
  final BoxShape shape;
  final BoxFit fit;
  final Border? border;
  final BorderRadius? borderRadius;
  final ImageEditorConfig editorConfig;

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorder =
        widget.border ??
        Border.all(
          color: theme.colorScheme.onPrimary,
        );

    return Center(
      child: BasePopover(
        alignmentOffset: Offset(-widget.size.width / 2, 0),
        menuChildren: (context, controller) => [
          constrainedMenuButton(
            FilledButton(
              onPressed: () {
                controller.close();
                widget.vm.onImageSelect(null);
              },
              child: Text(S.current.delete),
            ),
          ),
          constrainedMenuButton(
            ElevatedButton(
              onPressed: () async {
                controller.close();
                await pickImage(
                  context: context,
                  editorConfig: widget.editorConfig,
                  onImageSelect: widget.vm.onImageSelect,
                );
              },
              child: Text(S.current.selectAnotherImage),
            ),
          ),
        ],
        child: (context, controller) => ImagePreview(
          border: effectiveBorder,
          placeholder: widget.placeholder,
          source: widget.vm.image,
          onTap: () async => _handleTap(context, controller),
          size: widget.size,
          cacheSize: widget.cacheSize,
          shape: widget.shape,
          fit: widget.fit,
          borderRadius: widget.borderRadius,
        ),
      ),
    );
  }

  Future<void> _handleTap(
    BuildContext context,
    MenuController controller,
  ) async {
    if (controller.isOpen) {
      controller.close();
      return;
    }

    if (widget.vm.image.isNoImage) {
      await pickImage(
        context: context,
        editorConfig: widget.editorConfig,
        onImageSelect: widget.vm.onImageSelect,
      );
    } else {
      controller.open();
    }
  }
}
