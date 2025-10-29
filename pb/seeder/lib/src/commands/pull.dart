import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

import '../config/config.dart';
import '../models/result.dart';
import '../pb_client.dart';

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

    if (result case FailureResult(:final error)) {
      return error.code;
    }

    final config = result.value;

    final pb = PbClient(
      pbUrl: config.pbUrl,
      usernameOrEmail: config.usernameOrEmail,
      password: config.password,
      logger: _logger,
    );

    final logInResult = await pb.logInAsSuperuser();
    if (logInResult case FailureResult(:final error)) {
      return error.code;
    }

    return ExitCode.success.code;
  }
}
