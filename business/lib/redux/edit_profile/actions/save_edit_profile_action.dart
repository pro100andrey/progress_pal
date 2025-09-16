import 'package:async_redux/async_redux.dart';
import 'package:pb/collections.dart';

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../edit_profile_selectors.dart';

class SaveEditProfileAction extends ReduxAction<AppState> with WaitingFor {
  @override
  Future<AppState?> reduce() async {
    final fullName = selectEditProfileFullName(state);
    final birthdate = selectEditProfileBirthdate(state);

    await getPocketBase.x.users.update(
      state.session.currentUser!.id,
      body: UserBody(
        name: fullName,
        birthdate: birthdate,
      ),
    );

    return null;
  }
}
