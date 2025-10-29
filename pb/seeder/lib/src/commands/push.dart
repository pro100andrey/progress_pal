import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pocketbase/pocketbase.dart';

import '../config/config.dart';
import '../models/credentials.dart';
import '../pb_client.dart';
import '../utils/schema_checker.dart';
import '../utils/utils.dart';

class PushCommand extends Command {
  PushCommand({required Logger logger}) : _logger = logger {
    argParser
      ..addOption(
        'batch-size',
        abbr: 'b',
        help: 'Number of records to create per batch. Maximum is 50.',
        defaultsTo: '20',
      )
      ..addFlag(
        'truncate',
        abbr: 't',
        help: 'Whether to truncate existing collections before import',
      );
  }

  @override
  final name = 'push';

  @override
  final description =
      'Pushes the local PocketBase schema and seed data to the remote '
      'instance.';

  final Logger _logger;

  @override
  Future<int> run() async {
    // Load configuration
    final configResult = await resolveConfig(globalResults!, _logger);
    if (configResult case FailureResult(:final error)) {
      return error.code;
    }

    final config = configResult.value;

    final credentialsResult = resolveCredentials(
      globalResults!,
      _logger,
    );

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

    // Import the schema
    await _importPBSchema(config, pb);

    var batchSize = int.tryParse(argResults!['batch-size'] as String) ?? 20;
    if (batchSize <= 0 || batchSize > 50) {
      _logger.warn('Batch size must be between 1 and 50. Using default of 20.');
      batchSize = 20;
    }

    final truncateArg = argResults!['truncate'] as bool;
    if (truncateArg) {
      _logger.detail(
        'Truncate option enabled: Skipping confirmation prompt.',
      );
    }

    final truncate =
        truncateArg ||
        (terminalIsAttached() &&
            _logger.confirm('Truncate collections before seeding?'));

    await _seedCollections(
      pb: pb,
      config: config,
      batchSize: batchSize,
      truncate: truncate,
    );

    return ExitCode.success.code;
  }

  /// Imports the PocketBase schema from the specified JSON file into the
  /// connected PocketBase instance.
  Future<void> _importPBSchema(Config config, PbClient pb) async {
    // Fetch the current schema from the remote PocketBase instance
    final collectionsResult = await pb.getCollections();

    if (collectionsResult case FailureResult(:final error)) {
      _logger.err(
        'Failed to fetch remote schema: $error. '
        'Cannot proceed with schema import.',
      );
      return;
    }

    final fromServer = collectionsResult.value;
    final schemaFile = File(config.schemaFilePath);
    final schemaContent = await schemaFile.readAsString();
    final collectionsJson = jsonDecode(schemaContent) as List<dynamic>;
    // Convert JSON list to List<CollectionModel>
    final fromJsonFile = collectionsJson
        .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);

    _logger.info('Comparing local schema with remote schema...');
    final isSame = checkPBSchema(fromServer, fromJsonFile, _logger);

    if (isSame) {
      _logger.info(
        green.wrap('Schema is up to date!'),
      );
      return;
    }

    // Use the SDK's import method to update the remote schema.
    // Note: By default, this does NOT delete missing collections/fields.
    // To delete missing collections, set `deleteMissing: true` in the import
    // call. await pb.collections.import(collections, deleteMissing: true);
    await pb.importCollections(fromJsonFile);

    _logger.info(
      green.wrap('Schema imported/updated successfully!'),
    );
  }

  Future<void> _seedCollections({
    required PbClient pb,
    required Config config,
    required int batchSize,
    required bool truncate,
  }) async {
    final emptyMap = <String, bool>{};

    if (!truncate) {
      final seederResult = await pb.seeder();

      if (seederResult case FailureResult(:final error)) {
        _logger.err(
          'Failed to check seeder status: $error. '
          'Cannot proceed with seeding.',
        );
        return;
      }

      final seederView = seederResult.value;

      emptyMap['muscle_groups'] = seederView.muscleGroupsInfo.count == 0;
      emptyMap['equipments'] = seederView.equipmentsInfo.count == 0;
      emptyMap['recording_types'] = seederView.recordingTypesInfo.count == 0;
      emptyMap['exercises'] = seederView.systemExercisesInfo.count == 0;
    }

    if (!truncate && emptyMap.entries.any((e) => !e.value)) {
      _logger.info(
        'Not all collections are empty. Use --truncate option to force '
        'seeding.',
      );
    }

    for (final entry in config.seedMap.entries) {
      final jsonFile = entry.key;
      final collectionName = entry.value;

      final shouldProcess = truncate || (emptyMap[entry.value] ?? false);

      if (!shouldProcess) {
        _logger.info(
          'Skipping seeding for ${entry.value} as it is not empty.',
        );
        continue;
      }

      if (truncate) {
        final truncateResult = await pb.truncateCollection(collectionName);

        final shouldContinue = truncateResult.fold(
          (v) => true,
          (error) {
            _logger.err(
              'Failed to truncate $collectionName: $error. Seeding aborted.',
            );
            return false;
          },
        );

        if (!shouldContinue) {
          continue;
        }

        _logger.info('Truncated collection: $collectionName');
      }

      final file = File(jsonFile);

      final progress = _logger.progress('Reading $collectionName data...');
      final contents = await file.readAsString();
      // Ensure we are decoding to a List of dynamic maps
      final itemsToSeed = (jsonDecode(contents) as List)
          .cast<Map<String, dynamic>>();

      final totalItems = itemsToSeed.length;
      // This list will accumulate all created records from all batches
      final createdRecords = <BatchResult>[];
      // If total items are less than or equal to batch size, skip progress
      // updates
      final skipProgressUpdate = totalItems <= batchSize;

      for (var i = 0; i < totalItems; i += batchSize) {
        final end = (i + batchSize < totalItems) ? i + batchSize : totalItems;
        final batchItems = itemsToSeed.sublist(i, end);
        final batch = pb.instance.createBatch();

        for (final item in batchItems) {
          // Create a mutable copy and remove internal fields
          final itemBody = Map<String, dynamic>.from(item)
            ..remove('collectionId')
            ..remove('collectionName')
            ..remove('created')
            ..remove('updated');

          batch.collection(collectionName).create(body: itemBody);
        }

        // Send the batch and get the results
        final batchResult = await batch.send();

        // Add the records created in this batch to the main list
        createdRecords.addAll(batchResult);

        // Update progress unless skipping
        if (!skipProgressUpdate) {
          final currentTotalCreated = createdRecords.length;
          final percentage = (currentTotalCreated / totalItems * 100).round();
          progress.update(
            'Batch ${i ~/ batchSize + 1}: '
            'Created $currentTotalCreated / $totalItems items ($percentage%).',
          );
        }
      }

      progress.complete(
        'Seeding $collectionName completed. '
        'Created ${createdRecords.length} items.',
      );
    }
  }
}
