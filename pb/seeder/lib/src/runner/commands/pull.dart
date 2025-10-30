import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import '../../client/pb_client.dart';
import '../../models/credentials.dart';
import '../../models/failure.dart';

class PullCommand extends Command {
  PullCommand({required Logger logger}) : _logger = logger {
    argParser.addOption(
      'batch-size',
      abbr: 'b',
      help: 'Number of records to fetch per batch. Maximum is 500.',
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

    _logger
      ..info('Successfully authenticated as superuser.')
      ..detail('Token: ${logIn.value.token}.');

    // Get seeder view
    final seederView = await pb.seeder();
    if (seederView.isFailure) {
      _logger.err('Failed to get seeder view: ${seederView.errorMessage}');
      return seederView.error.exitCode;
    }

    // Fetch the current schema from the remote PocketBase instance
    final collections = await pb.getCollections();
    if (collections.isFailure) {
      return collections.error.exitCode;
    }

    final requiredCollections = [
      'equipments',
      'muscle_groups',
      'recording_types',
      'exercises',
    ];

    final requiredToFind = requiredCollections.toSet();
    for (final e in collections.value) {
      requiredToFind.remove(e.name);
      if (requiredToFind.isEmpty) {
        break;
      }
    }

    return ExitCode.success.code;
  }
}
