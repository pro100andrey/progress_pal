import 'package:async_redux/async_redux.dart';
import 'package:business/redux/app_state.dart';
import 'package:business/redux/current_profile/current_profile_selectors.dart';
import 'package:business/redux/edit_profile/actions/begin_edit_profile_action.dart';
import 'package:business/redux/edit_profile/actions/save_edit_profile_action.dart';
import 'package:business/redux/edit_profile/actions/set_avatar_action.dart';
import 'package:business/redux/edit_profile/actions/set_birthdate_action.dart';
import 'package:business/redux/edit_profile/actions/set_full_name_action.dart';
import 'package:business/redux/edit_profile/edit_profile_selectors.dart';
import 'package:business/redux/models/image_source.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui/dialogs/edit_profile_dialog.dart';
import 'package:ui/image/image_selector.dart';
import 'package:ui/image/model.dart';
import 'package:ui/models/value_changed.dart';

import '../../common/validators.dart';

class EditProfileDialogConnector extends StatelessWidget {
  const EditProfileDialogConnector({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _Vm>(
    debug: this,
    vm: () => _Factory(this),
    shouldUpdateModel: selectCurrentProfileIsSet,
    onInit: (store) {
      store.dispatchSync(BeginEditProfileAction());
    },
    builder: (context, vm) => EditProfileDialog(
      avatarSelector: vm.avatarSelector,
      fullName: vm.fullName,
      email: vm.email,
      birthdate: vm.birthdate,
      isAdmin: vm.isAdmin,
      isWriter: vm.isWriter,
      onPressedSave: vm.onPressedSave,
    ),
  );
}

/// Factory that creates a view-model for the StoreConnector.
class _Factory extends VmFactory<AppState, EditProfileDialogConnector, _Vm> {
  _Factory(super._connector);

  @override
  _Vm fromStore() {
    final currentUser = selectCurrentProfile(state)!;
    final fullName = selectEditProfileFullName(state);
    final birthdate = selectEditProfileBirthdate(state);
    final hasChanges = selectEditProfileHasChanges(state);
    final avatar = selectEditProfileAvatar(state);

    return _Vm(
      avatarSelector: ImageSelectorVm(
        image: switch (avatar) {
          MemoryImageSource(:final bytes, :final name) => ImageVm.memory(
            bytes: bytes,
            name: name,
          ),
          NetworkImageSource(:final url, :final name) => ImageVm.network(
            url: url,
            name: name,
          ),
          _ => const ImageVm.noImage(),
        },
        onImageSelect: (v) => dispatchSync(
          SetAvatarAction(
            avatar: switch (v) {
              MemoryImageVm(:final bytes, :final name) => MemoryImageSource(
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
        onChanged: (v) => dispatchSync(SetFullNameAction(fullName: v)),
        validator: nameValidator.call,
      ),
      email: ValueChangedVm(
        value: currentUser.email,
        enabled: false,
      ),
      birthdate: ValueChangedVm(
        value: birthdate,
        onChanged: (v) => dispatchSync(SetBirthdateAction(birthdate: v)),
      ),
      isAdmin: currentUser.isAdmin,
      isWriter: currentUser.isWriter,
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
    required this.isAdmin,
    required this.isWriter,
    required this.onPressedSave,
  });

  final ImageSelectorVm avatarSelector;
  final ValueChangedVm<String?> fullName;
  final ValueChangedVm<String?> email;
  final ValueChangedVm<DateTime?> birthdate;
  final bool isAdmin;
  final bool isWriter;
  final VoidCallback? onPressedSave;

  @override
  List<Object?> get props => [
    avatarSelector,
    fullName,
    email,
    birthdate,
    isAdmin,
    isWriter,
    onPressedSave != null,
  ];
}
