import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import '../../client/pb_client.dart';
import '../../models/credentials.dart';
import '../../models/failure.dart';
import '../../models/seed_data_config.dart';
import '../../utils/utils.dart';

class InitCommand extends Command {
  InitCommand({required Logger logger}) : _logger = logger {
    argParser.addOption(
      'data-dir',
      abbr: 'd',
      help: 'Path to the local seed data and schema directory.',
      mandatory: true,
    );
  }

  @override
  final name = 'init';

  @override
  final description = 'Initializes the local seed configuration';

  final Logger _logger;

  @override
  Future<int> run() async {
    final dataDir = resolveDataDir(argResults!['data-dir']);

    if (dataDir.isFailure) {
      _logger.err(dataDir.errorMessage);
      return dataDir.exitCode!;
    }

    final envPath = '${dataDir.value.path}/.env';
    final hasEnvFile = isPathExists(envPath);


    final credentials = resolveCredentialsWithUserInput();

    if (credentials.isFailure) {
      _logger.err(credentials.error.message);

      return credentials.error.exitCode;
    }

    final pb = PbClient(
      credentials: credentials.value,
    );

    final logInProgress = _logger.progress(
      'Attempting to authenticate with PocketBase...',
    );

    // Log in as superuser
    final logIn = await pb.logInAsSuperuser();
    if (logIn.isFailure) {
      logInProgress.fail('Authentication failed: ${logIn.errorMessage}');
      return logIn.error.exitCode;
    }

    logInProgress.complete('Successfully authenticated as superuser.');

    final confirmed = _logger.confirm(
      'Create .env file with these credentials?',
    );

    if (confirmed) {
      _logger.flush();
      return ExitCode.success.code;
    }

    // final credentials = resolveCredentials(globalResults!);
    // if (credentials.isFailure) {
    //   _logger.err(credentials.error.message);

    //   return credentials.error.exitCode;
    // }

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

    _logger.chooseAny(
      'Select collections to pull:',
      choices: requiredCollections,
    );

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
