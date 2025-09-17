import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/image_source.dart';

part 'edit_profile_state.freezed.dart';

@freezed
abstract class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    String? fullName,
    DateTime? birthdate,
    @Default(NoneImageSource()) ImageSource avatar,
  }) = _EditProfileState;
}
