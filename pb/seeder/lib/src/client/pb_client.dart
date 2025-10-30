import 'package:pocketbase/pocketbase.dart';

import '../models/credentials.dart';
import '../models/failure.dart';
import '../models/result.dart';
import '../models/seeder.dart';

export '../models/result.dart';
export '../models/seeder.dart';

final class PbClient {
  PbClient({
    required Credentials credentials,
  }) : _credentials = credentials,
       _pb = PocketBase(credentials.url);

  final Credentials _credentials;
  final PocketBase _pb;

  PocketBase get instance => _pb;

  Future<Result<RecordAuth, Failure>> logInAsSuperuser() async => _op(
    () async => _pb
        .collection('_superusers')
        .authWithPassword(_credentials.usernameOrEmail, _credentials.password),
  );

  Future<Result<List<CollectionModel>, Failure>> getCollections() async =>
      _op(() async => _pb.collections.getFullList());

  Future<Result<void, Failure>> importCollections(
    List<CollectionModel> collections, {
    bool deleteMissing = false,
  }) async => _op(
    () async => _pb.collections.import(
      collections,
      deleteMissing: deleteMissing,
    ),
  );

  Future<Result<void, Failure>> truncateCollection(
    String collectionName,
  ) async => _op(() async => _pb.collections.truncate(collectionName));

  Future<Result<SeederView, Failure>> seeder() async => _op(
    () async => SeederView(await _pb.collection('_seeder').getOne('-1')),
  );

  Future<Result<bool, Failure>> collectionIsEmpty(
    String collectionName,
  ) async => _op(() async {
    final existingItems = await _pb
        .collection(collectionName)
        .getList(perPage: 1, skipTotal: true);

    return existingItems.items.isEmpty;
  });

  /// Executes an operation and handles common PocketBase errors.
  Future<Result<T, Failure>> _op<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Result.success(result);
    } on ClientException catch (e) {
      final message = switch (e.response) {
        {'message': final String message} => '${e.statusCode} - $message',
        _ => 'Unexpected error',
      };

      final failure = Failure.fromHttpStatus(
        e.statusCode,
        message: message,
      );

      return Result.failure(failure);
    } on Object catch (e) {
      return Result.failure(
        Failure.software(message: 'Unexpected error: $e'),
      );
    }
  }
}
