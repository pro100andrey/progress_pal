import 'package:mason_logger/mason_logger.dart';

import '../client/pb_client.dart';
import '../extensions/logger.dart';
import '../extensions/string_style.dart';
import '../utils/utils.dart';
import 'failure.dart';

final class DataDir {
  DataDir._(
    this.exists,
    this.path,
  );

  final bool exists;
  final String path;
}

Result<DataDir, Failure> resolveDataDir(String dataDir) {
  final logger = Logger();

  final resolvedPath = resolvePath(dataDir)!;
  final exists = isPathExists(resolvedPath);
  final isDir = isDirectoryPath(resolvedPath);

  if (exists && !isDir) {
    return Failure.io(
      message: 'Path "$resolvedPath" exists but is not a directory.',
    ).toFailureResult();
  }

  final statusText = exists ? 'Exists'.lightRed : 'New'.lightGreen;
  final actionText = exists ? 'Overwrite'.lightRed : 'Create'.lightGreen;
  final confirmTitle = exists
      ? 'Overwrite existing data and proceed with synchronization?'
      : 'Create the data directory and start synchronization?';

  logger.section(
    title: '🎯 Data Directory Setup Summary:',
    items: {
      'Path': resolvedPath,
      'Status': statusText,
      'Action': actionText,
    },
  );

  final dataDirConfirmed = logger.confirm(confirmTitle, defaultValue: true);

  if (!dataDirConfirmed) {
    return Failure.userAborted(
      message: 'Operation aborted by user.',
    ).toFailureResult();
  }

  final dir = DataDir._(
    exists,
    resolvedPath,
  );

  return Result.success(dir);
}
