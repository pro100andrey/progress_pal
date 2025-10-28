import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../../services/profile_update/profile_update.dart';
import '../current_profile_selectors.dart';

class UnsubscribeCurrentProfileAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final service = prop<ProfileUpdateService>(kUpdateProfileServiceKey);
    await service.dispose();

    disposeProp(kUpdateProfileServiceKey);

    return null;
  }
}
