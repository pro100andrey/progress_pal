import 'package:equatable/equatable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

sealed class AvatarSource extends Equatable {
  const AvatarSource._();

  const factory AvatarSource.network(String? url) = _NetworkAvatarSrc;
  const factory AvatarSource.xfile(XFile? file) = _XFileAvatarSrc;

  bool get isEmpty => switch (this) {
    _NetworkAvatarSrc(url: final url) => url == null || url.isEmpty,
    _XFileAvatarSrc(file: final file) => file == null,
  };

  T? when<T>({
    required T Function(String url) network,
    required T Function(XFile file) xfile,
  }) {
    switch (this) {
      case _NetworkAvatarSrc(url: final url) when url != null:
        return network(url);
      case _XFileAvatarSrc(file: final file) when file != null:
        return xfile(file);
      case _:
        return null;
    }
  }
}

class _NetworkAvatarSrc extends AvatarSource {
  const _NetworkAvatarSrc(this.url) : super._();

  final String? url;

  @override
  List<Object?> get props => [url];
}

class _XFileAvatarSrc extends AvatarSource {
  const _XFileAvatarSrc(this.file) : super._();

  final XFile? file;

  @override
  List<Object?> get props => [file?.path, file?.name, file?.mimeType];
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
        placeholder ?? const Icon(LucideIcons.circleUser100, size: 32);
    final effectiveBorder =
        border ?? Border.all(color: const Color.fromARGB(255, 59, 59, 59));

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
      xfile: (file) => Builder(
        builder: (context) {
          if (kIsWeb) {
            return FutureBuilder(
              future: file.readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ExtendedImage.memory(
                    snapshot.data!,
                    shape: effectiveShape,
                    border: effectiveBorder,
                    loadStateChanged: loadStateChanged,
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            );
          } else {
            return const SizedBox();
          }
        },
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
