import 'dart:ui';

import 'package:extended_image/extended_image.dart';

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  /// Draw the mask over the crop area
  @override
  void paintMask(
    Canvas canvas,
    Rect rect,
    ExtendedImageCropLayerPainter painter,
  ) {
    final cropRect = painter.cropRect;
    final maskColor = painter.maskColor;

    final maskPath = Path()
      ..addRect(rect)
      ..addOval(cropRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(
      maskPath,
      Paint()
        ..style = PaintingStyle.fill
        ..color = maskColor,
    );
  }
}
