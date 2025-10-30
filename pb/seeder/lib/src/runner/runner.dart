import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import 'commands/pull.dart';
import 'commands/push.dart';

Future<int> run(List<String> args) async {
  final logger = Logger();

  final runner =
      CommandRunner(
          'seeder',
          'A utility for synchronizing PocketBase schemas and data.',
        )
        ..argParser.addOption(
          'host',
          abbr: 'H',
          help: 'PocketBase instance URL (e.g., http://localhost:8090)',
        )
        ..argParser.addOption(
          'username',
          abbr: 'u',
          help: 'Admin username/email',
        )
        ..argParser.addOption(
          'password',
          abbr: 'p',
          help: 'Admin password',
        )
        ..argParser.addOption(
          'env',
          abbr: 'e',
          help:
              'Path to the .env file containing environment variables '
              '(PB_URL, PB_USERNAME, PB_PASSWORD).',
        )
        ..argParser.addOption(
          'data-dir',
          abbr: 'd',
          help: 'Path to the local seed data and schema directory.',
          defaultsTo: 'data',
        )
        ..argParser.addFlag(
          'verbose',
          abbr: 'v',
          help: 'Enable verbose logging.',
          negatable: false,
          callback: (value) =>
              logger.level = value ? Level.verbose : Level.info,
        )
        ..addCommand(PushCommand(logger: logger))
        ..addCommand(PullCommand(logger: logger));

  try {
    final code = await runner.run(args);

    return code;
  } on Object catch (e) {
    final exception = e;

    if (e case UsageException() || ArgumentError()) {
      logger
        ..err(exception.toString())
        ..err('Rerun with --help for usage information.');
      return 64; // Exit code 64 indicates a usage error.
    }

    rethrow;
  }
}
