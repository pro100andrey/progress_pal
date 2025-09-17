import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../indicators/base_circle_indicator.dart';

sealed class AvatarSource extends Equatable {
  const AvatarSource._();

  factory AvatarSource.raw(Object? source) => switch (source) {
    final String url => AvatarSource.network(url: url),
    final Uint8List bytes => AvatarSource.memory(bytes: bytes),
    _ => const AvatarSource.none(),
  };

  const factory AvatarSource.none() = _NoneAvatarSrc;

  const factory AvatarSource.network({required String url}) = _NetworkAvatarSrc;

  const factory AvatarSource.memory({required Uint8List bytes}) =
      _MemoryAvatarSrc;

  T when<T>({
    required T Function() none,
    required T Function(String url) network,
    required T Function(Uint8List bytes) memory,
  }) {
    switch (this) {
      case _NetworkAvatarSrc(:final url):
        return network(url);
      case _MemoryAvatarSrc(:final bytes):
        return memory(bytes);
      case _NoneAvatarSrc():
        return none();
    }
  }

  bool get isNone => this is _NoneAvatarSrc;
}

class _NoneAvatarSrc extends AvatarSource {
  const _NoneAvatarSrc() : super._();

  @override
  List<Object?> get props => [];
}

class _NetworkAvatarSrc extends AvatarSource {
  const _NetworkAvatarSrc({required this.url}) : super._();

  final String url;

  @override
  List<Object?> get props => [url];
}

class _MemoryAvatarSrc extends AvatarSource {
  const _MemoryAvatarSrc({required this.bytes}) : super._();

  final Uint8List bytes;

  @override
  List<Object?> get props => [bytes.length];
}

class Avatar extends StatelessWidget {
  const Avatar({
    required this.source,
    this.size,
    this.placeholder,
    this.shape,
    this.fit,
    this.onTap,
    this.border,
    super.key,
  });

  final AvatarSource source;
  final Widget? placeholder;
  final Size? size;
  final BoxShape? shape;
  final BoxFit? fit;
  final VoidCallback? onTap;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final effectiveSize = size ?? const Size.square(40);
    final effectiveShape = shape ?? BoxShape.circle;
    final effectiveFit = fit ?? BoxFit.fill;
    final effectivePlaceholder =
        placeholder ?? const Icon(LucideIcons.user100, size: 18);
    final effectiveBorder =
        border ?? Border.all(color: const Color(0x483B3B3B));

    Widget? loadStateChanged(
      ExtendedImageState state,
    ) => switch (state.extendedImageLoadState) {
      LoadState.loading => const Center(
        child: BaseCircleIndicator(size: 24),
      ),
      LoadState.completed => ExtendedRawImage(
        image: state.extendedImageInfo?.image,
        width: effectiveSize.width,
        height: effectiveSize.height,
        fit: effectiveFit,
      ),
      LoadState.failed => Center(child: effectivePlaceholder),
    };

    final avatar = source.when(
      network: (url) => ExtendedImage.network(
        url,
        shape: effectiveShape,
        border: effectiveBorder,
        loadStateChanged: loadStateChanged,
      ),
      memory: (data) => ExtendedImage.memory(
        data,
        shape: effectiveShape,
        border: effectiveBorder,
        loadStateChanged: loadStateChanged,
      ),
      none: () => DecoratedBox(
        decoration: BoxDecoration(
          border: effectiveBorder,
          shape: effectiveShape,
          color: theme.colorScheme.card,
        ),
        child: Center(child: effectivePlaceholder),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: effectiveSize.width,
          height: effectiveSize.height,
          child: avatar,
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
