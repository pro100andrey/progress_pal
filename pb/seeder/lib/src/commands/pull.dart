import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import '../models/credentials.dart';
import '../pb_client.dart';

class PullCommand extends Command {
  PullCommand({required Logger logger}) : _logger = logger {
    argParser.addOption(
      'batch-size',
      abbr: 'b',
      help: 'Number of records to create per batch. Maximum is 500.',
      defaultsTo: '100',
    );
  }

  @override
  final name = 'pull';

  @override
  final description =
      'Pulls the remote PocketBase schema and collection data into local JSON '
      'files.';

  final Logger _logger;

  @override
  Future<int> run() async {
    final credentialsResult = resolveCredentials(globalResults!);
    if (credentialsResult case FailureResult(:final error)) {
      return error.exitCode;
    }

    final pb = PbClient(credentials: credentialsResult.value);

    // Log in as superuser
    final logIn = await pb.logInAsSuperuser();
    if (logIn.isFailure) {
      _logger.err('Failed to log in: ${logIn.error}');
      return logIn.error.exitCode;
    }

    final seeder = await pb.seeder();
    if (seeder.isFailure) {
      _logger.err('Failed to get seeder: ${seeder.error}');
      return seeder.error.exitCode;
    }

    // Fetch the current schema from the remote PocketBase instance
    final collections = await pb.getCollections();
    if (collections.isFailure) {
      return collections.error.exitCode;
    }

    return ExitCode.success.code;
  }
}
