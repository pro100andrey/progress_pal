import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pocketbase/pocketbase.dart';

import '../config/config.dart';
import '../models/result.dart';
import '../utils.dart';

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

    // Import the schema
    await _importPBSchema(pb, config.schemaFilePath);

    final truncateArg = argResults!['truncate'] as bool;

    if (truncateArg) {
      _logger.warn('Truncating collections before seeding data.');
    }

    var batchSize = int.tryParse(argResults!['batch-size'] as String) ?? 20;
    if (batchSize <= 0 || batchSize > 50) {
      _logger.warn('Batch size must be between 1 and 50. Using default of 20.');
      batchSize = 20;
    }

    final truncate =
        truncateArg ||
        (terminalIsAttached() &&
            _logger.confirm(
              'Truncate collections before seeding?',
            ));

    for (final entry in config.seedMap.entries) {
      final collectionName = entry.value;
      final jsonFile = entry.key;

      await _seedCollection(
        pb,
        collectionName: collectionName,
        jsonFile: jsonFile,
        batchSize: batchSize,
        truncate: truncate,
      );
    }

    return ExitCode.success.code;
  }

  /// Imports the PocketBase schema from the specified JSON file into the
  /// connected PocketBase instance.
  Future<void> _importPBSchema(PocketBase pb, String schemaFilePath) async {
    // Fetch the current schema from the remote PocketBase instance
    final fromServer = await pb.collections.getFullList();
    final schemaFile = File(schemaFilePath);
    final schemaContent = await schemaFile.readAsString();
    final collectionsJson = jsonDecode(schemaContent) as List<dynamic>;
    // Convert JSON list to List<CollectionModel>
    final fromJsonFile = collectionsJson
        .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);

    _logger.info('Comparing local schema with remote schema...');
    final isSame = _checkIsSamePBSchema(fromServer, fromJsonFile);

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
    await pb.collections.import(fromJsonFile);
    _logger.info(
      green.wrap('Schema imported/updated successfully!'),
    );
  }

  /// Compares two lists of CollectionModel to check for schema changes.
  ///
  /// It relies on collection name and content comparison.
  bool _checkIsSamePBSchema(
    List<CollectionModel> fromServer,
    List<CollectionModel> fromJsonFile,
  ) {
    if (fromServer.length != fromJsonFile.length) {
      _logger.detail(
        'Difference found: Collection count mismatch '
        '(${fromServer.length} vs ${fromJsonFile.length})',
      );
      return false;
    }
    // Sort both lists by collection name to ensure reliable element-wise
    // comparison
    fromServer.sort((a, b) => a.name.compareTo(b.name));
    fromJsonFile.sort((a, b) => a.name.compareTo(b.name));

    for (var i = 0; i < fromServer.length; i++) {
      final existingCollection = fromServer[i];
      final incomingCollection = fromJsonFile[i];
      // Sanity check after sorting
      if (existingCollection.name != incomingCollection.name) {
        _logger.detail(
          'Difference found: Collection name mismatch at '
          'index $i (${existingCollection.name} vs ${incomingCollection.name})',
        );
        return false;
      }

      // Compare collection content (rules, type, fields, etc.)
      if (!_isSameCollectionContent(existingCollection, incomingCollection)) {
        _logger.detail(
          'Difference found in collection: ${existingCollection.name}',
        );
        return false;
      }
    }

    return true;
  }

  /// Compares two CollectionModel instances for content equality,
  /// ignoring internal, volatile fields like 'id', 'created', and 'updated'.
  bool _isSameCollectionContent(CollectionModel a, CollectionModel b) {
    // Create copies of the maps for normalization and comparison
    final aMap = a.toJson();
    final bMap = b.toJson();

    // Remove internal fields
    aMap
      ..remove('id')
      ..remove('created')
      ..remove('updated');

    bMap
      ..remove('id')
      ..remove('created')
      ..remove('updated');

    // Normalize fields for comparison (order might differ)
    final aFields = (aMap['fields'] as List<dynamic>?) ?? [];
    final bFields = (bMap['fields'] as List<dynamic>?) ?? [];

    if (aFields.length != bFields.length) {
      _logger.detail('Field count mismatch');
      return false;
    }

    // Create maps of fields keyed by field name
    final aFieldsMap = {
      for (final f in aFields) (f as Map<String, dynamic>)['name']: f,
    };
    final bFieldsMap = {
      for (final f in bFields) (f as Map<String, dynamic>)['name']: f,
    };

    // Check if both collections have the exact same set of field names
    if (aFieldsMap.keys
        .toSet()
        .difference(bFieldsMap.keys.toSet())
        .isNotEmpty) {
      _logger.detail('Field names mismatch');
      return false;
    }

    // Remove the field lists from the main maps to compare them separately
    aMap.remove('fields');
    bMap.remove('fields');

    // Compare main collection properties (rules, type, etc.)
    if (jsonEncode(aMap) != jsonEncode(bMap)) {
      _logger.detail('Collection properties mismatch (excluding fields)');
      return false;
    }

    // Compare each field individually
    for (final name in aFieldsMap.keys) {
      final fieldA = aFieldsMap[name]!;
      final fieldB = bFieldsMap[name]!;

      // Remove field IDs, as they are internal and volatile
      fieldA.remove('id');
      fieldB.remove('id');
      // Compare the rest of the field properties (type, required, options,
      // etc.)
      if (jsonEncode(fieldA) != jsonEncode(fieldB)) {
        _logger.detail('Difference in field "$name" content');
        return false;
      }
    }

    return true;
  }

  Future<void> _seedCollection(
    PocketBase pb, {
    required String collectionName,
    required String jsonFile,
    required int batchSize,
    required bool truncate,
  }) async {
    if (truncate) {
      await pb.collections.truncate(collectionName);
    } else {
      final collection = pb.collection(collectionName);
      final existingItems = await collection.getList(page: 1, perPage: 1);

      if (existingItems.items.isNotEmpty) {
        _logger.warn(
          '$collectionName collection is not empty. Seeding aborted to prevent '
          'duplicates. \n'
          'Use --truncate option to clear the collection before seeding.',
        );
        return;
      }
    }

    final file = File(jsonFile);

    final contents = await file.readAsString();
    // Ensure we are decoding to a List of dynamic maps
    final itemsToSeed = (jsonDecode(contents) as List)
        .cast<Map<String, dynamic>>();

    final totalItems = itemsToSeed.length;
    // This list will accumulate all created records from all batches
    final createdRecords = <BatchResult>[];

    final progress = _logger.progress('Seeding $collectionName');
    // If total items are less than or equal to batch size, skip progress
    // updates
    final skipProgressUpdate = totalItems <= batchSize;

    for (var i = 0; i < totalItems; i += batchSize) {
      final end = (i + batchSize < totalItems) ? i + batchSize : totalItems;
      final batchItems = itemsToSeed.sublist(i, end);
      final batch = pb.createBatch();

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
        progress.update(
          'Batch ${i ~/ batchSize + 1}, '
          'created ${batchResult.length} items. '
          'total: $currentTotalCreated / $totalItems.',
        );
      }
    }

    progress.complete(
      'Seeding $collectionName completed. '
      'Created ${createdRecords.length} items.',
    );
  }
}
