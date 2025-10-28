import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

sealed class ImageVm extends Equatable {
  const factory ImageVm.noImage() = NoImageVm;

  const factory ImageVm.network({required String url, required String name}) =
      NetworkImageVm;

  const factory ImageVm.memory({
    required Uint8List bytes,
    required String name,
  }) = MemoryImageVm;
  const ImageVm._();

  static const maxAvatarRadius = 50.0;
  static const maxAvatarSize = Size.fromRadius(maxAvatarRadius);
  static const maxExerciseSize = Size(512, 512);

  bool get isNetwork => this is NetworkImageVm;
  bool get isMemory => this is MemoryImageVm;
  bool get isNoImage => this is NoImageVm;

  T when<T>({
    required T Function() none,
    required T Function(String url) network,
    required T Function(Uint8List bytes) memory,
  }) {
    switch (this) {
      case NetworkImageVm(:final url):
        return network(url);
      case MemoryImageVm(:final bytes):
        return memory(bytes);
      case NoImageVm():
        return none();
    }
  }
}

class NoImageVm extends ImageVm {
  const NoImageVm() : super._();

  @override
  List<Object?> get props => [];
}

class NetworkImageVm extends ImageVm {
  const NetworkImageVm({required this.url, required this.name}) : super._();

  final String url;
  final String name;

  @override
  List<Object?> get props => [url, name];
}

class MemoryImageVm extends ImageVm {
  const MemoryImageVm({required this.bytes, required this.name}) : super._();

  final Uint8List bytes;
  final String name;

  @override
  List<Object?> get props => [bytes.length, name];
}
