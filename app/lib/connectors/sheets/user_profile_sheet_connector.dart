import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/session/actions/clean_session_action.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/avatar.dart';
import 'package:ui/image/avatar_selector.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/sheets/user_profile_sheet.dart';

import '../../common/validators.dart';
import '../../navigation/navigation.dart';

class UserProfileSheetConnector extends StatelessWidget {
  const UserProfileSheetConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    builder: (context, vm) => UserProfileSheet(
      avatarSelector: vm.avatarSelector,
      fullName: vm.fullName,
      email: vm.email,
      birthdate: vm.birthdate,
      onPressedSave: vm.onPressedSave,
      onPressedLogout: vm.onPressedLogout,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, UserProfileSheetConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() => _Vm(
    avatarSelector: AvatarSelectorVm(
      src: const AvatarSource.memory(null),
      onImageSelect: (xfile) => {},
    ),
    fullName: ValueChangedVm(
      value: 'John Doe',
      onChanged: (value) {},
      validator: nameValidator.call,
    ),
    email: const ValueChangedVm(
      value: 'john.doe@example.com',
      enabled: false,
    ),
    birthdate: ValueChangedVm(
      value: DateTime.now(),
      onChanged: (value) {},
      validator: (value) {
        if (value == null) {
          return 'A date of birth is required.';
        }
        return null;
      },
    ),
    onPressedSave: null,
    onPressedLogout: () async {
      await dispatchAndWait(CleanSessionAction());
      navigation.refresh();
    },
  );
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.avatarSelector,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.onPressedSave,
    required this.onPressedLogout,
  });

  final AvatarSelectorVm avatarSelector;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final VoidCallback? onPressedSave;
  final VoidCallback onPressedLogout;

  @override
  List<Object?> get props => [
    avatarSelector,
    fullName,
    email,
    birthdate,
    onPressedSave != null,
  ];
}
