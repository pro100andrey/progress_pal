import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../indicators/base_circle_indicator.dart';
import 'model.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    required this.source,
    this.size,
    this.placeholder,
    this.shape = BoxShape.rectangle,
    this.fit = BoxFit.cover,
    this.cacheSize,
    this.onTap,
    this.border,
    this.borderRadius,
    super.key,
  });

  ImagePreview.avatar({
    required this.source,
    super.key,
    double sizeRadius = 16,
    double placeholderIconSize = 16,
    this.cacheSize,
  }) : placeholder = Icon(LucideIcons.user, size: placeholderIconSize),
       size = Size.fromRadius(sizeRadius),
       shape = BoxShape.circle,
       fit = BoxFit.cover,
       onTap = null,
       border = null,
       borderRadius = BorderRadius.circular(sizeRadius);

  final ImageVm source;
  final Widget? placeholder;
  final Size? size;
  final Size? cacheSize;
  final BoxShape shape;
  final BoxFit fit;
  final VoidCallback? onTap;
  final Border? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectivePlaceholder =
        placeholder ?? const Icon(LucideIcons.image, size: 18);

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

    final image = source.when(
      network: (url) {
        final cacheKey = _cacheKey(cacheSize, url);

        return ExtendedImage.network(
          url,
          shape: shape,
          border: border,
          width: size?.width,
          height: size?.height,
          loadStateChanged: loadStateChanged,
          cacheWidth: cacheSize?.width.toInt(),
          cacheHeight: cacheSize?.height.toInt(),
          cacheKey: cacheKey,
          borderRadius: shape == BoxShape.circle ? null : borderRadius,
          fit: fit,
        );
      },
      memory: (data) => ExtendedImage.memory(
        data,
        width: size?.width,
        height: size?.height,
        shape: shape,
        border: border,
        loadStateChanged: loadStateChanged,
        cacheHeight: cacheSize?.height.toInt(),
        cacheWidth: cacheSize?.width.toInt(),
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        fit: fit,
      ),
      none: () => DecoratedBox(
        decoration: BoxDecoration(
          border: border,
          shape: shape,
          borderRadius: shape == BoxShape.circle ? null : borderRadius,
        ),
        child: Center(child: effectivePlaceholder),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        if (size != null)
          SizedBox(
            width: size!.width,
            height: size!.height,
            child: image,
          )
        else
          Positioned.fill(child: image),

        if (onTap != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
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

/// Cache key generator for ExtendedImage network cache.
/// Uses FNV-1a hash algorithm to generate a short and unique key based on the
/// image URL and the desired cache size.
/// This helps to avoid issues with long URLs and ensures that different sizes
/// of the same image are cached separately.
final Map<String, String> _keyCache = {};

/// Generates a cache key for the given URL and cache size.
/// Returns null if cacheSize is null.
String? _cacheKey(Size? cacheSize, String url) {
  if (cacheSize == null) {
    return null;
  }
  final cacheWidth = cacheSize.width.toInt();
  final cacheHeight = cacheSize.height.toInt();

  final rawKey = '${url}_${cacheWidth}_$cacheHeight';

  if (_keyCache.containsKey(rawKey)) {
    return _keyCache[rawKey];
  }

  final fnv1a = _fnv1a(rawKey);
  final key = fnv1a.toRadixString(36);
  _keyCache[rawKey] = key;

  return key;
}

/// FNV-1a hash algorithm implementation.
/// Produces a 32-bit hash value for the given input string.
int _fnv1a(String input) {
  const fnvPrime = 0x01000193;
  const fnvOffset = 0x811c9dc5;
  var hash = fnvOffset;

  for (final codeUnit in input.codeUnits) {
    hash ^= codeUnit;
    hash = (hash * fnvPrime) & 0xffffffff;
  }

  return hash;
}
