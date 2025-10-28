import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pocketbase/pocketbase.dart';

import '../config/config.dart';
import '../models/result.dart';

class PullCommand extends Command {
  PullCommand({required Logger logger}) : _logger = logger;

  @override
  final name = 'pull';

  @override
  final description =
      'Pulls the remote PocketBase schema and collection data into local JSON '
      'files.';

  final Logger _logger;

  @override
  Future<int> run() async {
    final result = Config.loadFromFile(globalResults!, _logger);

    if (result case FailureResult<Config, int>(:final error)) {
      return error;
    }

    final config = (result as SuccessResult<Config>).value;

    final pb = PocketBase(config.pbUrl);
    final authResponse = await pb
        .collection('_superusers')
        .authWithPassword(config.adminEmail, config.adminPassword);

    _logger.info('Authenticated as: ${authResponse.record.get('email')}');

    return ExitCode.success.code;
  }
}
