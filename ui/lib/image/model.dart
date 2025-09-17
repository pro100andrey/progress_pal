import 'dart:typed_data';

import 'package:equatable/equatable.dart';

sealed class ImageVm extends Equatable {
  const ImageVm._();

  factory ImageVm.raw(Object? source) => switch (source) {
    final String url => ImageVm.network(url: url),
    final Uint8List bytes => ImageVm.memory(bytes: bytes),
    _ => const ImageVm.none(),
  };

  const factory ImageVm.none() = _None;

  const factory ImageVm.network({required String url}) = _Network;

  const factory ImageVm.memory({required Uint8List bytes}) = _Memory;

  T when<T>({
    required T Function() none,
    required T Function(String url) network,
    required T Function(Uint8List bytes) memory,
  }) {
    switch (this) {
      case _Network(:final url):
        return network(url);
      case _Memory(:final bytes):
        return memory(bytes);
      case _None():
        return none();
    }
  }

  bool get isNone => this is _None;
}

class _None extends ImageVm {
  const _None() : super._();

  @override
  List<Object?> get props => [];
}

class _Network extends ImageVm {
  const _Network({required this.url}) : super._();

  final String url;

  @override
  List<Object?> get props => [url];
}

class _Memory extends ImageVm {
  const _Memory({required this.bytes}) : super._();

  final Uint8List bytes;

  @override
  List<Object?> get props => [bytes.length];
}
