import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_source.freezed.dart';

@freezed
sealed class ImageSource with _$ImageSource {
  const factory ImageSource.none() = NoneImageSource;

  const factory ImageSource.network({
    required String url,
    required String name,
  }) = NetworkImageSource;

  const factory ImageSource.memory({
    required Uint8List bytes,
    required String name,
  }) = MemoryImageSource;
}
