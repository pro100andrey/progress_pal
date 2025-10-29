import 'package:mason_logger/mason_logger.dart';

abstract class SeederException implements Exception {
  const SeederException(this.message, this.exitCode);
  final String message;
  final ExitCode exitCode;

  @override
  String toString() => '$runtimeType: $message (Exit Code: ${exitCode.code})';
}

class ConfigLoadException extends SeederException {
  const ConfigLoadException(String message)
    : super(
        message,
        ExitCode.noInput,
      );
}
