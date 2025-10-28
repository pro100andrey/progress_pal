import 'package:async_redux/async_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:storage/storage.dart';

import 'environment.dart';
import 'redux/app_state.dart';
import 'redux/language/actions/load_language_action.dart';
import 'redux/services/connectivity/connectivity.dart';
import 'redux/services/connectivity/connectivity_driver.dart';
import 'redux/session/actions/load_session_action.dart';
import 'redux/session/actions/save_session_action.dart';
import 'redux/session/session_selectors.dart';
import 'redux/theme/actions/load_theme_mode_action.dart';

// ambient variable to access the service locator
final _locator = GetIt.instance;

ConnectivityService get getConnectivity => _locator.get<ConnectivityService>();
KeyValueStorage get getSettingsStorage => _locator.get<KeyValueStorage>();
PocketBase get getPB => _locator.get<PocketBase>();

Future<void> initSettingsStorage(Store<AppState> store) async {
  final settingsStorage = KeyValueStorage();
  await settingsStorage.setupStorage(dbFile: 'pp.db');
  _locator.registerSingleton(settingsStorage);

  await store.dispatchAndWaitAll([
    LoadSessionAction(),
    LoadLanguageAction(),
    LoadThemeModeAction(),
  ]);
}

Future<void> initLocator(Store<AppState> store, Environment env) async {
  // Connectivity Service
  final connectivity = ConnectivityService(
    driver: ConnectivityDriver(store: store),
  );

  await connectivity.start();
  _locator.registerSingleton(connectivity);

  final authStore = AsyncAuthStore(
    save: (pbAuth) async =>
        store.dispatchAndWait(SaveSessionAction(pbAuth: pbAuth)),
    initial: selectSessionPBAuth(store.state),
  );

  final pb = PocketBase(env.pbUrl, authStore: authStore);
  _locator.registerSingleton(pb);
}
