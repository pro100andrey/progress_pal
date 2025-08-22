import 'package:async_redux/async_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:storage/storage.dart';

import 'environment.dart';
import 'redux/app_state.dart';
import 'redux/services/connectivity/connectivity.dart';
import 'redux/services/connectivity/connectivity_driver.dart';

// ambient variable to access the service locator
final _locator = GetIt.instance;

ConnectivityService get getConnectivity => _locator.get<ConnectivityService>();
KeyValueStorage get getSettingsStorage => _locator.get<KeyValueStorage>();
PocketBase get getPocketBase => _locator.get<PocketBase>();

void configure(Store<AppState> store) {}

Future<void> initLocator(Store<AppState> store, Environment env) async {
  final settingsStorage = KeyValueStorage();
  await settingsStorage.setupStorage(dbFile: 'pp.db');
  _locator.registerSingleton(settingsStorage);

  // Connectivity Service
  final connectivity = ConnectivityService(
    driver: ConnectivityDriver(store: store),
  );

  await connectivity.start();
  _locator.registerSingleton(connectivity);

  final authStore = AsyncAuthStore(
    save: (data) async => settingsStorage.put('pb_auth', data),
    initial: settingsStorage.getSync('pb_auth'),
  );

  final pb = PocketBase(
    'https://progress-pal.pockethost.io/',
    authStore: authStore,
  );

  _locator.registerSingleton(pb);
}
