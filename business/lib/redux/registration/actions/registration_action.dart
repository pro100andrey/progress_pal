import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;

import '../../action_mixins/waiting_for.dart';
import '../../app_state.dart';
import '../../models/image_source.dart';
import '../models/registration_state.dart';
import '../registration_selectors.dart';

class RegistrationAction extends ReduxAction<AppState> with BaseWrapError {
  @override
  Future<AppState?> reduce() async {
    final fullName = selectRegistrationFullName(state)!;
    final email = selectRegistrationEmail(state)!;
    final birthdate = selectRegistrationBirthdate(state)!;
    final password = selectRegistrationPassword(state)!;
    final avatar = selectRegistrationAvatar(state);

    await getPB
        .collection('users')
        .create(
          body: {
            'email': email,
            'emailVisibility': true,
            'name': fullName,
            'birthdate': birthdate.toIso8601String(),
            'password': password,
            'passwordConfirm': password,
          },
          files: [
            if (avatar is MemoryImageSource)
              http.MultipartFile.fromBytes(
                'avatar',
                avatar.bytes,
                filename: avatar.name,
              ),
          ],
        );

    await getPB.collection('users').requestVerification(email);

    return state.copyWith(registration: const RegistrationState());
  }
}
