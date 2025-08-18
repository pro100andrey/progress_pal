import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

sealed class AvatarSource {
  const AvatarSource._();

  const factory AvatarSource.network(String url) = _NetworkAvatarSrc;
  const factory AvatarSource.asset(String name) = _AssetAvatarSrc;

  T when<T>({
    required T Function(String url) network,
    required T Function(String name) asset,
  }) {
    switch (this) {
      case _NetworkAvatarSrc(url: final url):
        return network(url);
      case _AssetAvatarSrc(name: final name):
        return asset(name);
    }
  }
}

class _NetworkAvatarSrc extends AvatarSource {
  const _NetworkAvatarSrc(this.url) : super._();

  final String url;
}

class _AssetAvatarSrc extends AvatarSource {
  const _AssetAvatarSrc(this.name) : super._();

  final String name;
}

class Avatar extends StatelessWidget {
  const Avatar({
    required this.source,
    this.size,
    this.placeholder,
    this.shape,
    this.backgroundColor,
    this.fit,
    this.onTap,
    super.key,
  });

  final AvatarSource source;
  final Widget? placeholder;
  final Size? size;
  final BoxShape? shape;
  final Color? backgroundColor;
  final BoxFit? fit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? const Size.square(40);
    final backgroundColor = this.backgroundColor ?? const Color(0xFF2E2C31);
    final effectiveShape = shape ?? BoxShape.circle;
    final effectiveFit = fit ?? BoxFit.contain;

    return Stack(
      alignment: Alignment.center,
      children: [
        source.when(
          network: (url) => ExtendedImage.network(
            url,
            mode: ExtendedImageMode.gesture,

            shape: effectiveShape,
            width: effectiveSize.width,
            height: effectiveSize.height,
            border: Border.all(
              color: backgroundColor,
              width: 2,
            ),
            fit: effectiveFit,
            onDoubleTap: (state) => debugPrint('Avatar double tapped'),
            loadStateChanged: (state) => switch (state.extendedImageLoadState) {
              LoadState.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              LoadState.completed => ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: effectiveSize.width,
                height: effectiveSize.height,
              ),

              LoadState.failed => Center(child: placeholder),
            },
          ),
          asset: ExtendedImage.asset,
        ),

        if (onTap != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(effectiveSize.width / 2),
              onTap: onTap,
              child: SizedBox(
                width: effectiveSize.width,
                height: effectiveSize.height,
              ),
            ),
          ),
      ],
    );
  }
}
