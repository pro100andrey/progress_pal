import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/edit_profile/actions/begin_edit_profile_action.dart';
import 'package:business/redux/edit_profile/actions/save_edit_profile_action.dart';
import 'package:business/redux/edit_profile/actions/set_avatar_action.dart';
import 'package:business/redux/edit_profile/actions/set_birthdate_action.dart';
import 'package:business/redux/edit_profile/actions/set_full_name_action.dart';
import 'package:business/redux/edit_profile/edit_profile_selectors.dart';
import 'package:business/redux/models/image_source.dart';
import 'package:business/redux/session/session_selectors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/image/avatar_selector.dart';
import 'package:ui/image/model.dart';
import 'package:ui/models/value_changed.dart';
import 'package:ui/sheets/edit_profile_sheet.dart';

import '../../common/validators.dart';

class EditProfileSheetConnector extends StatelessWidget {
  const EditProfileSheetConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    shouldUpdateModel: selectSessionIsLoggedIn,
    onInit: (store) {
      store.dispatchSync(BeginEditProfileAction());
    },
    builder: (context, vm) => EditProfileSheet(
      avatarSelector: vm.avatarSelector,
      fullName: vm.fullName,
      email: vm.email,
      birthdate: vm.birthdate,
      onPressedSave: vm.onPressedSave,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, EditProfileSheetConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final currentUser = selectSessionCurrentUser(state)!;
    final fullName = selectEditProfileFullName(state);
    final birthdate = selectEditProfileBirthdate(state);
    final hasChanges = selectEditProfileHasChanges(state);
    final avatar = selectEditProfileAvatar(state);

    return _Vm(
      avatarSelector: AvatarSelectorVm(
        image: switch (avatar) {
          MemoryImageSource(:final bytes) => ImageVm.memory(bytes: bytes),
          NetworkImageSource(:final url) => ImageVm.network(url: url),
          _ => const ImageVm.none(),
        },
        onImageSelect: (v) => dispatchSync(
          SetAvatarAction(
            avatar: switch (v) {
              (:final bytes, :final name) => MemoryImageSource(
                bytes: bytes,
                name: name,
              ),
              null => const NoneImageSource(),
            },
          ),
        ),
      ),
      fullName: ValueChangedVm(
        value: fullName,
        onChanged: (v) => dispatchSync(SetFullNameAction(fullName: v!)),
        validator: nameValidator.call,
      ),
      email: ValueChangedVm(
        value: currentUser.email,
        enabled: false,
      ),
      birthdate: ValueChangedVm(
        value: birthdate,
        onChanged: (v) => dispatchSync(SetBirthdateAction(birthdate: v!)),
      ),
      onPressedSave: hasChanges
          ? () => dispatch(SaveEditProfileAction())
          : null,
    );
  }
}

/// The view-model holds the part of the Store state the dumb-widget needs.
class _Vm extends Vm with EquatableMixin {
  _Vm({
    required this.avatarSelector,
    required this.fullName,
    required this.email,
    required this.birthdate,
    required this.onPressedSave,
  });

  final AvatarSelectorVm avatarSelector;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final VoidCallback? onPressedSave;

  @override
  List<Object?> get props => [
    avatarSelector,
    fullName,
    email,
    birthdate,
    onPressedSave != null,
  ];
}
