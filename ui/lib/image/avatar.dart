import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

typedef AvatarMemoryData = ({Uint8List bytes, String name});
typedef AvatarNetworkData = String?;

sealed class AvatarSource extends Equatable {
  const AvatarSource._();

  const factory AvatarSource.network(AvatarNetworkData? data) =
      _NetworkAvatarSrc;
  const factory AvatarSource.memory(AvatarMemoryData? data) = _MemoryAvatarSrc;

  bool get isEmpty => switch (this) {
    _NetworkAvatarSrc(data: final data) => data == null,
    _MemoryAvatarSrc(data: final data) => data == null,
  };

  T? when<T>({
    required T Function(String url) network,
    required T Function(AvatarMemoryData data) memory,
  }) {
    switch (this) {
      case _NetworkAvatarSrc(data: final data) when data != null:
        return network(data);
      case _MemoryAvatarSrc(data: final data) when data != null:
        return memory(data);
      case _:
        return null;
    }
  }
}

class _NetworkAvatarSrc extends AvatarSource {
  const _NetworkAvatarSrc(this.data) : super._();

  final AvatarNetworkData? data;

  @override
  List<Object?> get props => [data];
}

class _MemoryAvatarSrc extends AvatarSource {
  const _MemoryAvatarSrc(this.data) : super._();

  final ({Uint8List bytes, String name})? data;

  @override
  List<Object?> get props => [data?.name];
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
    final effectiveSize = size ?? const Size.square(40);
    final effectiveShape = shape ?? BoxShape.circle;
    final effectiveFit = fit ?? BoxFit.fill;
    final effectivePlaceholder =
        placeholder ?? const Icon(LucideIcons.user100, size: 24);
    final effectiveBorder =
        border ?? Border.all(color: const Color(0xFF3B3B3B));

    Widget? loadStateChanged(
      ExtendedImageState state,
    ) => switch (state.extendedImageLoadState) {
      LoadState.loading => const Center(
        child: CircularProgressIndicator(),
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
        data.bytes,
        shape: effectiveShape,
        border: effectiveBorder,
        loadStateChanged: loadStateChanged,
      ),
    );

    final resultAvatar = SizedBox(
      width: effectiveSize.width,
      height: effectiveSize.height,
      child:
          avatar ??
          DecoratedBox(
            decoration: BoxDecoration(
              border: effectiveBorder,
              shape: effectiveShape,
            ),
            child: Center(child: effectivePlaceholder),
          ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        resultAvatar,

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
