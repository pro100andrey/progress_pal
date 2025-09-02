import 'package:sembast/sembast.dart';

import 'base_key_value_storage.dart';
import 'sembast/sembast_setup_mixin.dart';

final class KeyValueStorage extends BaseKeyValueStorage with SembastSetupMixin {
  static const String _kPBAuthKey = 'pb_auth';

  @override
  Future<void> clear() async => mainStore.delete(db);

  @override
  Future<void> delete(String key) async {
    await mainStore.record(key).delete(db);
  }

  @override
  Future<T?> get<T>(String key) async =>
      await mainStore.record(key).get(db) as T?;

  T? getSync<T>(String key) => mainStore.record(key).getSync(db) as T?;

  @override
  Future<void> put<T>(String key, T value) async =>
      mainStore.record(key).put(db, value);
}

extension KeyValueStorageX on KeyValueStorage {
  Future<void> setPBAuth(String? value) async =>
      put(KeyValueStorage._kPBAuthKey, value);

  Future<String?> getPBAuth() async => get<String>(KeyValueStorage._kPBAuthKey);

  Future<void> deletePBAuth() async => delete(KeyValueStorage._kPBAuthKey);
}
