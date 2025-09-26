import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../indicators/base_circle_indicator.dart';
import 'model.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    required this.source,
    this.size,
    this.placeholder,
    this.shape = BoxShape.rectangle,
    this.fit = BoxFit.cover,
    this.cacheSize = const Size(400, 400),
    this.onTap,
    this.border,
    this.borderRadius,
    super.key,
  });

  final ImageVm source;
  final Widget? placeholder;
  final Size? size;
  final Size cacheSize;
  final BoxShape shape;
  final BoxFit fit;
  final VoidCallback? onTap;
  final Border? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final effectivePlaceholder =
        placeholder ?? const Icon(LucideIcons.image100, size: 18);

    Widget? loadStateChanged(
      ExtendedImageState state,
    ) => switch (state.extendedImageLoadState) {
      LoadState.loading => const Center(
        child: BaseCircleIndicator(size: 24),
      ),
      LoadState.completed => ExtendedRawImage(
        image: state.extendedImageInfo?.image,
        width: size?.width,
        height: size?.height,
        fit: fit,
      ),
      LoadState.failed => Center(child: effectivePlaceholder),
    };

    final avatar = source.when(
      network: (url) {
        final cacheWidth = cacheSize.width.toInt();
        final cacheHeight = cacheSize.height.toInt();
        final u64 = base64UrlEncode(utf8.encode(url));
        final cacheKey = '${u64}_${cacheWidth}_$cacheHeight';

        return ExtendedImage.network(
          url,
          shape: shape,
          border: border,
          loadStateChanged: loadStateChanged,
          cacheHeight: cacheHeight,
          cacheWidth: cacheWidth,
          cacheKey: cacheKey,
          borderRadius: borderRadius,
          fit: fit,
        );
      },
      memory: (data) => ExtendedImage.memory(
        data,
        shape: shape,
        border: border,
        loadStateChanged: loadStateChanged,
        borderRadius: borderRadius,
        fit: fit,
      ),
      none: () => DecoratedBox(
        decoration: BoxDecoration(
          border: border,
          shape: shape,
          color: theme.colorScheme.card,
          borderRadius: borderRadius,
        ),
        child: Center(child: effectivePlaceholder),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(child: avatar),

        if (onTap != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onTap,
              child: SizedBox(
                width: size?.width,
                height: size?.height,
              ),
            ),
          ),
      ],
    );
  }
}
