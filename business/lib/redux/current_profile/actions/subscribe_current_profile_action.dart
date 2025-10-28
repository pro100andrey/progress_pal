import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../services/profile_update/profile_update.dart';
import '../../services/profile_update/profile_update_driver.dart';
import '../current_profile_selectors.dart';

class SubscribeCurrentProfileAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final currentUser = selectCurrentProfile(state)!;
    final driver = ProfileUpdateDriver(store: store);
    final service = ProfileUpdateService(
      driver: driver,
      pb: getPB,
      userId: currentUser.id,
    );

    await service.start();

    setProp(kUpdateProfileServiceKey, service);

    return null;
  }
}
