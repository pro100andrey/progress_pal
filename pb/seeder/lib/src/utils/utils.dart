import 'dart:io' as io;

import 'package:path/path.dart' as p;

String? resolvePath(String? path) => path != null ? p.canonicalize(path) : null;

bool isFilePath(String path) {
  final type = io.FileSystemEntity.typeSync(path);
  return type == io.FileSystemEntityType.file;
}

bool isPathExists(String? path) =>
    path != null &&
    io.FileSystemEntity.typeSync(path) != io.FileSystemEntityType.notFound;

bool checkFileExtension(String? path, String ext) =>
    path != null && p.extension(path).toLowerCase() == ext.toLowerCase();

bool terminalIsAttached() {
  final hasTerminal =
      io.IOOverrides.current?.stdout.hasTerminal ?? io.stdout.hasTerminal;

  return hasTerminal;
}
