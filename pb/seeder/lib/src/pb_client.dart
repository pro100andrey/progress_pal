import 'package:mason_logger/mason_logger.dart';
import 'package:pocketbase/pocketbase.dart';

import 'models/result.dart';

/// A view of the seeder status in the PocketBase instance.
typedef SeederView = ({
  int muscleGroupsCount,
  int equipmentsCount,
  int recordingTypesCount,
  int systemExercisesCount,
});

final class PbClient {
  PbClient({
    required String pbUrl,
    required String usernameOrEmail,
    required String password,
    required Logger logger,
  }) : _usernameOrEmail = usernameOrEmail,
       _password = password,
       _logger = logger,
       _pb = PocketBase(pbUrl);

  final Logger _logger;
  final String _usernameOrEmail;
  final String _password;
  final PocketBase _pb;

  PocketBase get instance => _pb;

  /// Authenticates the client as a superuser with the PocketBase instance.
  ///
  /// Returns a [Result] containing either the authenticated [RecordModel]
  /// on success or an [ExitCode] on failure.
  Future<Result<RecordAuth, ExitCode>> logInAsSuperuser() async => _op(
    () async => _pb
        .collection('_superusers')
        .authWithPassword(_usernameOrEmail, _password),
    onSuccess: (authResponse) {
      _logger.detail('Auth token: ${authResponse.token}');
    },
  );

  /// Retrieves the list of collections from the PocketBase instance.
  ///
  /// Returns a [Result] containing either the list of [CollectionModel]s
  /// on success or an [ExitCode] on failure.
  Future<Result<List<CollectionModel>, ExitCode>> getCollections() async =>
      _op(() async => _pb.collections.getFullList());

  /// Imports the provided [collections] into the PocketBase instance.
  ///
  /// If [deleteMissing] is `true`, collections and schema fields not present
  /// in the imported configuration will be deleted.
  ///
  /// Returns a [Result] containing either `null` on success or an [ExitCode]
  /// on failure.
  Future<Result<void, ExitCode>> importCollections(
    List<CollectionModel> collections, {
    bool deleteMissing = false,
  }) async => _op(
    () async => _pb.collections.import(
      collections,
      deleteMissing: deleteMissing,
    ),
  );

  /// Truncates all records in the specified [collectionName].
  ///
  /// Returns a [Result] containing either `null` on success or an [ExitCode]
  /// on failure.
  Future<Result<void, ExitCode>> truncateCollection(
    String collectionName,
  ) async => _op(() async => _pb.collections.truncate(collectionName));

  Future<Result<SeederView, ExitCode>> seeder() async => _op(() async {
    final existingItems = await _pb
        .collection('_seeder')
        .getOne(
          '-1',
          fields: [
            'muscle_groups_count',
            'equipments_count',
            'recording_types_count',
            'system_exercises_count',
          ].join(','),
        );

    return (
      muscleGroupsCount: existingItems.get<int>('muscle_groups_count'),
      equipmentsCount: existingItems.get<int>('equipments_count'),
      recordingTypesCount: existingItems.get<int>('recording_types_count'),
      systemExercisesCount: existingItems.get<int>('system_exercises_count'),
    );
  });

  /// Checks if the specified [collectionName] is empty.
  ///
  /// Returns a [Result] containing either `true` if empty, `false` otherwise,
  /// or an [ExitCode] on failure.
  Future<Result<bool, ExitCode>> collectionIsEmpty(
    String collectionName,
  ) async => _op(() async {
    final existingItems = await _pb
        .collection(collectionName)
        .getList(perPage: 1, skipTotal: true);

    return existingItems.items.isEmpty;
  });

  /// Executes an operation and handles common PocketBase errors.
  Future<Result<T, ExitCode>> _op<T>(
    Future<T> Function() operation, {
    void Function(T value)? onSuccess,
  }) async {
    try {
      final result = await operation();
      onSuccess?.call(result);

      return Result.success(result);
    } on ClientException catch (e) {
      final message =
          e.response['message'] ??
          (e.statusCode == 404 ? 'Resource not found' : 'Unexpected error');

      _logger.err('$message (status code: ${e.statusCode})');

      return Result.failure(
        e.statusCode == 404 ? ExitCode.noInput : ExitCode.unavailable,
      );
    } on Object catch (e) {
      _logger.err('$e');
      return Result.failure(ExitCode.software);
    }
  }
}
