import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:localization/generated/l10n.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor({
    required this.bytes,
    this.cropLayerPainter,
    this.maxSize,
    super.key,
  });

  @override
  State<ImageEditor> createState() => _ImageEditorState();

  final Uint8List bytes;
  final Size? maxSize;
  final EditorCropLayerPainter? cropLayerPainter;
}

class _ImageEditorState extends State<ImageEditor> {
  final _editorController = ImageEditorController();

  @override
  Widget build(BuildContext context) => Column(
    spacing: 16,
    children: [
      Expanded(
        child: ExtendedImage.memory(
          widget.bytes,
          mode: ExtendedImageMode.editor,
          fit: BoxFit.contain,
          initEditorConfigHandler: (state) => EditorConfig(
            maxScale: 8,
            cropAspectRatio: CropAspectRatios.ratio1_1,
            cropRectPadding: const EdgeInsets.all(32),
            initCropRectType: InitCropRectType.layoutRect,
            cornerColor: const Color(0xFF535463),
            controller: _editorController,
            hitTestSize: 25,
            cropLayerPainter:
                widget.cropLayerPainter ?? const EditorCropLayerPainter(),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ShadTooltip(
            builder: (context) => Text(S.current.rotateCw),
            child: ShadButton.outline(
              child: const Icon(LucideIcons.rotateCw),
              onPressed: () => _editorController.rotate(
                animation: true,
              ),
            ),
          ),
          ShadTooltip(
            builder: (context) => Text(S.current.rotateCcw),
            child: ShadButton.outline(
              child: const Icon(LucideIcons.rotateCcw),
              onPressed: () => _editorController.rotate(
                degree: -90,
                animation: true,
              ),
            ),
          ),
          ShadTooltip(
            builder: (context) => Text(S.current.reset),
            child: ShadButton.outline(
              onPressed: _editorController.reset,
              child: const Icon(LucideIcons.history),
            ),
          ),
          ShadButton(
            onPressed: () async {
              final result = await _editorController.exportImage(widget.bytes);
              if (context.mounted) {
                Navigator.of(context).pop(result);
              }
            },
            child: Text(S.current.done),
          ),
        ],
      ),
    ],
  );
}

extension ImageEditorControllerExport on ImageEditorController {
  Future<Uint8List?> exportImage(Uint8List raw, {Size? maxSize}) async {
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

    return resultImage;
  }
}
