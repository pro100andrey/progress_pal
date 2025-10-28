import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:localization/generated/l10n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'circle_editor_crop_layer_painter.dart';

class ImageEditorConfig extends Equatable {
  factory ImageEditorConfig.circle({
    BoxConstraints editorConstraints = const BoxConstraints(
      maxWidth: 600,
      maxHeight: 500,
    ),
    Size? maxImageSize,
  }) => ImageEditorConfig._(
    cropLayerPainter: const CircleEditorCropLayerPainter(),
    maxImageSize: maxImageSize,
    editorConstraints: editorConstraints,
  );

  factory ImageEditorConfig.square({
    BoxConstraints editorConstraints = const BoxConstraints(
      maxWidth: 600,
      maxHeight: 500,
    ),
    Size? maxImageSize,
  }) => ImageEditorConfig._(
    maxImageSize: maxImageSize,
    cropLayerPainter: const EditorCropLayerPainter(),
    editorConstraints: editorConstraints,
  );
  const ImageEditorConfig._({
    required this.cropLayerPainter,
    required this.editorConstraints,
    this.maxImageSize,
  });

  final Size? maxImageSize;
  final EditorCropLayerPainter cropLayerPainter;
  final BoxConstraints editorConstraints;

  @override
  List<Object?> get props => [cropLayerPainter, maxImageSize];
}

class ImageEditor extends StatefulWidget {
  const ImageEditor({
    required this.bytes,
    required this.config,
    super.key,
  });

  @override
  State<ImageEditor> createState() => ImageEditorState();

  final ImageEditorConfig config;
  final Uint8List bytes;
}

class ImageEditorState extends State<ImageEditor> {
  final _editorController = ImageEditorController();

  /// Exports the edited image.
  Future<EditorResult?> exportImage() async {
    final result = await _editorController.exportImage(
      widget.bytes,
      maxSize: widget.config.maxImageSize,
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Flexible(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(),
              clipBehavior: Clip.hardEdge,
              child: ExtendedImage.memory(
                clearMemoryCacheWhenDispose: true,
                constraints: const BoxConstraints(
                  minWidth: 500,
                  minHeight: 500,
                  maxWidth: 500,
                  maxHeight: 500,
                ),
                widget.bytes,
                mode: ExtendedImageMode.editor,
                fit: BoxFit.contain,
                initEditorConfigHandler: (state) => EditorConfig(
                  maxScale: 8,
                  cropAspectRatio: CropAspectRatios.ratio1_1,
                  cropRectPadding: const EdgeInsets.all(16),
                  initCropRectType: InitCropRectType.layoutRect,
                  cornerColor: theme.colorScheme.primary,
                  controller: _editorController,
                  hitTestSize: 25,
                  cropLayerPainter: widget.config.cropLayerPainter,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tooltip(
              message: S.current.rotateCw,
              child: IconButton(
                icon: const Icon(LucideIcons.rotateCw),
                onPressed: () => _editorController.rotate(
                  animation: true,
                ),
              ),
            ),
            Tooltip(
              message: S.current.rotateCcw,
              child: IconButton(
                icon: const Icon(LucideIcons.rotateCcw),
                onPressed: () => _editorController.rotate(
                  degree: -90,
                  animation: true,
                ),
              ),
            ),
            Tooltip(
              message: S.current.reset,
              child: IconButton(
                onPressed: _editorController.reset,
                icon: const Icon(LucideIcons.history),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

typedef EditorResult = ({Uint8List bytes, String ext});

extension ImageEditorControllerExport on ImageEditorController {
  Future<EditorResult?> exportImage(Uint8List raw, {Size? maxSize}) async {
    final cropRect = getCropRect();
    final rotate = rotateDegrees;

    var image = img.decodeImage(raw);
    image = img.bakeOrientation(image!);

    if (cropRect != null) {
      image = img.copyCrop(
        image,
        x: cropRect.left.toInt(),
        y: cropRect.top.toInt(),
        width: cropRect.width.toInt(),
        height: cropRect.height.toInt(),
      );
    }

    if (rotate != 0) {
      image = img.copyRotate(image, angle: rotate);
    }

    if (maxSize != null) {
      image = img.copyResize(
        image,
        width: maxSize.width.toInt(),
        height: maxSize.height.toInt(),
      );
    }

    final resultImage = img.encodeJpg(image);

    return (bytes: resultImage, ext: 'jpg');
  }
}
