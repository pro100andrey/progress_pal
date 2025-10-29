import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../utils/dotenv_parser.dart';
import '../utils/utils.dart';
import 'result.dart';

/// Model class to hold PocketBase admin credentials.
final class Credentials {
  Credentials({
    required this.url,
    required this.usernameOrEmail,
    required this.password,
  });

  /// The PocketBase instance URL.
  final String url;

  /// The admin username or email.
  final String usernameOrEmail;

  /// The admin password.
  final String password;
}

/// Attempts to determine and load the PocketBase admin credentials
/// from command-line arguments or environment variables defined in a .env file.
///
/// The function prioritizes environment variables from the .env file.
/// It returns [Result.success] with the [Credentials] object if all three
/// required pieces of information (url, username/email, password) are found.
/// Otherwise, it returns [Result.failure] with the appropriate [ExitCode]
Result<Credentials, ExitCode> resolveCredentials(
  ArgResults args,
  Logger logger,
) {
  final dotenvFile = args['env'] as String?;
  final resolvedDotenvFile = resolvePath(dotenvFile);
  final dotenvResult = tryParseDotenv(resolvedDotenvFile);

  switch (dotenvResult) {
    case DotenvResultFileNotFound():
      logger.err(
        'The specified .env file was not found: $resolvedDotenvFile',
      );
      return Result.failure(ExitCode.ioError);
    case DotenvResultIsNotAFile():
      logger.err(
        'The specified .env path is not a file: $resolvedDotenvFile',
      );
      return Result.failure(ExitCode.usage);
    case DotenvResultInvalid():
      logger.err(
        'The specified .env file is missing required variables: '
        'PB_URL, PB_ADMIN_EMAIL, PB_ADMIN_PASSWORD',
      );
      return Result.failure(ExitCode.usage);

    case DotenvResultData():
      break;
    case null:
      throw UnimplementedError();
  }

  final dotenv = dotenvResult as DotenvResultData?;
  // Priority: 1. .env file, 2. Command-line argument
  final pbUrl = dotenv?.url ?? args['url'] as String?;
  final usernameOrEmail = dotenv?.username ?? args['username'] as String?;
  final password = dotenv?.password ?? args['password'] as String?;
  // Validate presence of all required fields
  if (pbUrl == null || usernameOrEmail == null || password == null) {
    logger.err(
      'Missing connection details. You must provide either:'
      '\n1. All three global options: --url, --username, and --password.'
      '\n2. The global option -e, --env, pointing to a file with connection '
      'variables.',
    );

    return Result.failure(ExitCode.usage);
  }

  final credentials = Credentials(
    url: pbUrl,
    usernameOrEmail: usernameOrEmail,
    password: password,
  );

  return Result.success(credentials);
}
