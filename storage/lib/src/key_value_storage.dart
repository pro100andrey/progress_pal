import 'package:sembast/sembast.dart';

import 'base_key_value_storage.dart';
import 'sembast/sembast_setup_mixin.dart';

final class KeyValueStorage extends BaseKeyValueStorage with SembastSetupMixin {
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

extension KeyValueStoragePB on KeyValueStorage {
  static const String kPBAuthKey = 'pb_auth';

  Future<void> setPBAuth(String? value) async => put(kPBAuthKey, value);
  Future<String?> getPBAuth() async => get<String>(kPBAuthKey);
  Future<void> deletePBAuth() async => delete(kPBAuthKey);
}

extension KeyValueStorageLocale on KeyValueStorage {
  static const String kLocaleKey = 'locale';

  Future<void> setLocale(String value) async => put(kLocaleKey, value);
  Future<String?> getLocale() async => get<String>(kLocaleKey);
  Future<void> deleteLocale() async => delete(kLocaleKey);
}

extension KeyValueStorageTheme on KeyValueStorage {
  static const String kThemeModeKey = 'theme_mode';

  Future<void> setThemeMode(int value) async => put(kThemeModeKey, value);
  Future<int?> getThemeMode() async => get<int>(kThemeModeKey);
  Future<void> deleteThemeMode() async => delete(kThemeModeKey);
}
