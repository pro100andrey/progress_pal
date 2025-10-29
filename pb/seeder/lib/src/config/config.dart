import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';

import '../dotenv_parser.dart';
import '../models/result.dart';
import '../utils.dart';

/// Holds the configuration for the seeder application.
///
/// This class is responsible for loading and validating the configuration
/// from command-line arguments and a .env file.
final class Config {
  Config._({
    required this.schemaFilePath,
    required this.equipmentFilePath,
    required this.muscleGroupsFilePath,
    required this.recordingTypesFilePath,
    required this.seedMap,
    required this.pbUrl,
    required this.usernameOrEmail,
    required this.password,
  });

  /// The path to the PocketBase schema file.
  final String schemaFilePath;

  /// The path to the equipment data file.
  final String equipmentFilePath;

  /// The path to the muscle groups data file.
  final String muscleGroupsFilePath;

  /// The path to the recording types data file.
  final String recordingTypesFilePath;

  /// A map of file paths to collection names for seeding.
  final Map<String, String> seedMap;

  /// The PocketBase url.
  final String pbUrl;

  /// The PocketBase admin email or username.
  final String usernameOrEmail;

  /// The PocketBase admin password.
  final String password;

  /// Loads the configuration from the command-line arguments and .env file.
  ///
  /// It resolves paths, validates the presence of required files and
  /// connection details, and returns a [Result] containing either the
  /// [Config] instance or an error code.
  static Result<Config, ExitCode> loadFromFile(
    ArgResults globalResults,
    Logger logger,
  ) {
    final dotenvFile = globalResults['env'] as String?;
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
    final pbUrl = dotenv?.url ?? globalResults['url'] as String?;
    final usernameOrEmail =
        dotenv?.username ?? globalResults['username'] as String?;
    final password = dotenv?.password ?? globalResults['password'] as String?;
    if (pbUrl == null || usernameOrEmail == null || password == null) {
      logger.err(
        'Missing connection details. You must provide either:'
        '\n1. All three global options: --url, --username, and --password.'
        '\n2. The global option -e, --env, pointing to a file with connection '
        'variables.',
      );
      return Result.failure(ExitCode.usage);
    }

    final data = globalResults['data-folder'] as String;
    final dataFolder = resolvePath(data);

    if (!isPathExists(dataFolder)) {
      logger.err(
        'Data folder not found: $dataFolder\n'
        'Use --data-folder or -d option to specify the correct folder.',
      );

      return Result.failure(ExitCode.ioError);
    }

    final schemaFilePath = '$dataFolder/pb_schema.json';
    final equipmentFilePath = '$dataFolder/equipments.json';
    final muscleGroupsFilePath = '$dataFolder/muscle_groups.json';
    final recordingTypesFilePath = '$dataFolder/recording_types.json';

    final requiredFiles = <String, String?>{
      schemaFilePath: null,
      equipmentFilePath: 'equipments',
      muscleGroupsFilePath: 'muscle_groups',
      recordingTypesFilePath: 'recording_types',
    };

    final missingFiles = requiredFiles.keys.where(
      (filePath) => !isPathExists(filePath),
    );

    if (missingFiles.isNotEmpty) {
      for (final filePath in missingFiles) {
        logger.err('Required seed file not found: $filePath');
      }
      return Result.failure(ExitCode.ioError);
    }

    final seedMap = {
      for (final entry in requiredFiles.entries) entry.key: ?entry.value,
    };

    final config = Config._(
      schemaFilePath: schemaFilePath,
      equipmentFilePath: equipmentFilePath,
      muscleGroupsFilePath: muscleGroupsFilePath,
      recordingTypesFilePath: recordingTypesFilePath,
      seedMap: seedMap,
      pbUrl: pbUrl,
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    logger.detail('Loaded configuration: $config');

    return SuccessResult(config);
  }

  @override
  String toString() {
    final buf = StringBuffer()
      ..writeln()
      ..writeln('Config:')
      ..writeln('  schemaFilePath: $schemaFilePath')
      ..writeln('  equipmentFilePath: $equipmentFilePath')
      ..writeln('  muscleGroupsFilePath: $muscleGroupsFilePath')
      ..writeln('  recordingTypesFilePath: $recordingTypesFilePath')
      ..writeln('  seedMap: {')
      ..writeAll(
        seedMap.entries.map(
          (e) => '    ${e.key}: ${e.value}',
        ),
        '\n',
      )
      ..writeln('  }')
      ..writeln('  pbUrl: $pbUrl')
      ..writeln('  usernameOrEmail: $usernameOrEmail')
      ..writeln('  password: ${'*' * password.length}');

    return buf.toString();
  }
}
