// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:seeder/src/commands/pull.dart';
import 'package:seeder/src/commands/push.dart';

Future<void> main(List<String> args) async {
  final logger = Logger();

  final runner =
      CommandRunner(
          'seeder',
          'A utility for synchronizing PocketBase schemas and data.',
        )
        ..argParser.addOption(
          'url',
          help: 'PocketBase instance URL (e.g., http://localhost:8090)',
        )
        ..argParser.addOption(
          'username',
          help: 'Admin username/email',
        )
        ..argParser.addOption(
          'password',
          help: 'Admin password',
        )
        ..argParser.addOption(
          'env',
          abbr: 'e',
          help:
              'Path to the .env file containing environment variables '
              '(PB_URL, PB_ADMIN_EMAIL, PB_ADMIN_PASSWORD).',
        )
        ..argParser.addOption(
          'data-folder',
          abbr: 'd',
          help: 'Folder containing the pb_schema.json and data files.',
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

  final code = await runner.run(args).catchError((error) {
    final exception = error as Object?;

    switch (exception) {
      case UsageException() || ArgumentError():
        print(exception);
        print('Rerun with --help for usage information.');
        exit(64); // Exit code 64 indicates a usage error.
      case _:
        throw error;
    }
  });

  exit(code ?? 0);
}
