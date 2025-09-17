// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {

 String? get fullName; DateTime? get birthdate; ImageSource get avatar;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,birthdate,avatar);

@override
String toString() {
  return 'EditProfileState(fullName: $fullName, birthdate: $birthdate, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 String? fullName, DateTime? birthdate, ImageSource avatar
});


$ImageSourceCopyWith<$Res> get avatar;

}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? birthdate = freezed,Object? avatar = null,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageSourceCopyWith<$Res> get avatar {
  
  return $ImageSourceCopyWith<$Res>(_self.avatar, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}



/// @nodoc


class _EditProfileState implements EditProfileState {
  const _EditProfileState({this.fullName, this.birthdate, this.avatar = const NoneImageSource()});
  

@override final  String? fullName;
@override final  DateTime? birthdate;
@override@JsonKey() final  ImageSource avatar;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfileStateCopyWith<_EditProfileState> get copyWith => __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfileState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,birthdate,avatar);

@override
String toString() {
  return 'EditProfileState(fullName: $fullName, birthdate: $birthdate, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$EditProfileStateCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(_EditProfileState value, $Res Function(_EditProfileState) _then) = __$EditProfileStateCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, DateTime? birthdate, ImageSource avatar
});


@override $ImageSourceCopyWith<$Res> get avatar;

}
/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(this._self, this._then);

  final _EditProfileState _self;
  final $Res Function(_EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? birthdate = freezed,Object? avatar = null,}) {
  return _then(_EditProfileState(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImageSourceCopyWith<$Res> get avatar {
  
  return $ImageSourceCopyWith<$Res>(_self.avatar, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}
}

// dart format on
