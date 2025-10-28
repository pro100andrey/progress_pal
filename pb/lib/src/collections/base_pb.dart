import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

abstract class PBCollection {
  const PBCollection(this.pocketBase);

  final PocketBase pocketBase;

  String get collectionName;
}

// ignore: one_member_abstracts
abstract class PBToJson {
  const PBToJson();

  Map<String, dynamic> toJson();
}

mixin PBUpdateMixin<R extends RecordModel, B extends PBToJson> on PBCollection {
  /// Update an existing record.
  Future<R> update(
    String id, {
    required B body,
    Map<String, dynamic> query = const {},
    List<http.MultipartFile> files = const [],
    Map<String, String> headers = const {},
    String? expand,
    String? fields,
  }) async {
    final response = await pocketBase
        .collection(collectionName)
        .update(
          id,
          body: body.toJson(),
          query: query,
          files: files,
          headers: headers,
          expand: expand,
          fields: fields,
        );

    return response as R;
  }
}

mixin PBCreateMixin<R extends RecordModel, B extends PBToJson> on PBCollection {
  /// Create a new record.
  Future<R> create({
    required B body,
    Map<String, dynamic> query = const {},
    List<http.MultipartFile> files = const [],
    Map<String, String> headers = const {},
    String? expand,
    String? fields,
  }) async {
    final response = await pocketBase
        .collection(collectionName)
        .create(
          body: body.toJson(),
          query: query,
          files: files,
          headers: headers,
          expand: expand,
          fields: fields,
        );

    return response as R;
  }
}

mixin PBDeleteMixin on PBCollection {
  /// Delete a record.
  Future<void> delete(
    String id, {
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    await pocketBase
        .collection(collectionName)
        .delete(id, query: query, headers: headers);
  }
}

/// View mixin for PocketBase collections.
mixin PBViewMixin<R extends RecordModel> on PBCollection {
  /// Fetch a single record;
  Future<R> getOne(
    String id, {
    String? expand,
    String? fields,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    final response = await pocketBase
        .collection(collectionName)
        .getOne(
          id,
          expand: expand,
          fields: fields,
          query: query,
          headers: headers,
        );

    return response as R;
  }
}

/// List/Search mixin for PocketBase collections.
mixin PBListMixin<R extends RecordModel> on PBCollection {
  /// Fetch a full list of records.
  Future<List<R>> getFullList({
    int batch = 500,
    String? expand,
    String? filter,
    String? sort,
    String? fields,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    final response = await pocketBase
        .collection(collectionName)
        .getFullList(
          batch: batch,
          expand: expand,
          filter: filter,
          sort: sort,
          fields: fields,
          query: query,
          headers: headers,
        );

    return response as List<R>;
  }

  /// Fetch a paginated list of records.
  Future<ResultList<R>> getList({
    int page = 1,
    int perPage = 30,
    bool skipTotal = false,
    String? expand,
    String? filter,
    String? sort,
    String? fields,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    final response = await pocketBase
        .collection(collectionName)
        .getList(
          page: page,
          perPage: perPage,
          skipTotal: skipTotal,
          expand: expand,
          filter: filter,
          sort: sort,
          fields: fields,
          query: query,
          headers: headers,
        );

    return response as ResultList<R>;
  }

  /// Fetch the first item from a list of records.
  Future<R> getFirstListItem(
    String filter, {
    String? expand,
    String? fields,
    Map<String, dynamic> query = const {},
    Map<String, String> headers = const {},
  }) async {
    final response = await pocketBase
        .collection(collectionName)
        .getFirstListItem(
          filter,
          expand: expand,
          fields: fields,
          query: query,
          headers: headers,
        );

    return response as R;
  }
}
