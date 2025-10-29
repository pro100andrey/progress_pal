import 'package:args/args.dart';
import 'package:io/io.dart';
import 'package:mason_logger/mason_logger.dart';

import '../models/result.dart';
import '../utils/process.dart';
import '../utils/utils.dart';

/// Holds the configuration for the seeder application.
///
/// This class is responsible for loading and validating the configuration
/// from command-line arguments and a .env file.
final class Config {
  Config._({
    required this.dataFolder,
    required this.schemaFilePath,
    required this.equipmentFilePath,
    required this.muscleGroupsFilePath,
    required this.recordingTypesFilePath,
    required this.seedMap,
  });

  /// The path to the data folder containing seed files.
  final String dataFolder;

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

  @override
  String toString() {
    final buf = StringBuffer()
      ..writeln()
      ..writeln('Config:')
      ..writeln('  dataFolder: $dataFolder')
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
      ..writeln('  }');

    return buf.toString();
  }
}

/// Resolves the configuration from the command-line arguments and .env file.
///
/// It resolves the data folder path, validates required seed files,
/// and constructs the [Config] object.
/// Returns [Result.success] with the [Config] if successful,
/// otherwise returns [Result.failure] with the appropriate [ExitCode].
Future<Result<Config, ExitCode>> resolveConfig(
  ArgResults globalResults,
  Logger logger,
) async {
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

  final dartVersion = await getDartVersionOutput();

  final config = Config._(
    dataFolder: dataFolder!,
    schemaFilePath: schemaFilePath,
    equipmentFilePath: equipmentFilePath,
    muscleGroupsFilePath: muscleGroupsFilePath,
    recordingTypesFilePath: recordingTypesFilePath,
    seedMap: seedMap,
  );

  logger.detail('Loaded configuration: $config');

  return SuccessResult(config);
}
