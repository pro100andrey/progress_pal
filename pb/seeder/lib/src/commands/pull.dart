import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import '../config/config.dart';
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
    // Load configuration
    final configResult = await resolveConfig(globalResults!, _logger);
    if (configResult case FailureResult(:final error)) {
      return error.code;
    }

    final config = configResult.value;

    final credentialsResult = resolveCredentials(globalResults!, _logger);
    if (credentialsResult case FailureResult(:final error)) {
      return error.code;
    }

    final pb = PbClient(
      credentials: credentialsResult.value,
      logger: _logger,
    );

    // Log in as superuser
    final logIn = await pb.logInAsSuperuser();
    if (logIn case FailureResult(:final error)) {
      return error.code;
    }

    final seederResult = await pb.seeder();
    if (seederResult case FailureResult(:final error)) {
      return error.code;
    }

    // Fetch the current schema from the remote PocketBase instance
    final collectionsResult = await pb.getCollections();
    if (collectionsResult case FailureResult(:final error)) {
      return error.code;
    }

    return ExitCode.success.code;
  }
}
