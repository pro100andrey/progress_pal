// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationState {

 String? get fullName; String? get email; DateTime? get birthdate; String? get password; String? get confirmPassword; ImageSource get avatar;
/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegistrationStateCopyWith<RegistrationState> get copyWith => _$RegistrationStateCopyWithImpl<RegistrationState>(this as RegistrationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,birthdate,password,confirmPassword,avatar);

@override
String toString() {
  return 'RegistrationState(fullName: $fullName, email: $email, birthdate: $birthdate, password: $password, confirmPassword: $confirmPassword, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $RegistrationStateCopyWith<$Res>  {
  factory $RegistrationStateCopyWith(RegistrationState value, $Res Function(RegistrationState) _then) = _$RegistrationStateCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? email, DateTime? birthdate, String? password, String? confirmPassword, ImageSource avatar
});


$ImageSourceCopyWith<$Res> get avatar;

}
/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._self, this._then);

  final RegistrationState _self;
  final $Res Function(RegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? birthdate = freezed,Object? password = freezed,Object? confirmPassword = freezed,Object? avatar = null,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,confirmPassword: freezed == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String?,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}
/// Create a copy of RegistrationState
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


class _RegistrationState implements RegistrationState {
  const _RegistrationState({this.fullName, this.email, this.birthdate, this.password, this.confirmPassword, this.avatar = const NoneImageSource()});
  

@override final  String? fullName;
@override final  String? email;
@override final  DateTime? birthdate;
@override final  String? password;
@override final  String? confirmPassword;
@override@JsonKey() final  ImageSource avatar;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationStateCopyWith<_RegistrationState> get copyWith => __$RegistrationStateCopyWithImpl<_RegistrationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegistrationState&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,birthdate,password,confirmPassword,avatar);

@override
String toString() {
  return 'RegistrationState(fullName: $fullName, email: $email, birthdate: $birthdate, password: $password, confirmPassword: $confirmPassword, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$RegistrationStateCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory _$RegistrationStateCopyWith(_RegistrationState value, $Res Function(_RegistrationState) _then) = __$RegistrationStateCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? email, DateTime? birthdate, String? password, String? confirmPassword, ImageSource avatar
});


@override $ImageSourceCopyWith<$Res> get avatar;

}
/// @nodoc
class __$RegistrationStateCopyWithImpl<$Res>
    implements _$RegistrationStateCopyWith<$Res> {
  __$RegistrationStateCopyWithImpl(this._self, this._then);

  final _RegistrationState _self;
  final $Res Function(_RegistrationState) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? birthdate = freezed,Object? password = freezed,Object? confirmPassword = freezed,Object? avatar = null,}) {
  return _then(_RegistrationState(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,confirmPassword: freezed == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String?,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}

/// Create a copy of RegistrationState
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
