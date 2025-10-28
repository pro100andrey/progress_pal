// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentProfileState {

 User? get user;
/// Create a copy of CurrentProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentProfileStateCopyWith<CurrentProfileState> get copyWith => _$CurrentProfileStateCopyWithImpl<CurrentProfileState>(this as CurrentProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentProfileState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'CurrentProfileState(user: $user)';
}


}

/// @nodoc
abstract mixin class $CurrentProfileStateCopyWith<$Res>  {
  factory $CurrentProfileStateCopyWith(CurrentProfileState value, $Res Function(CurrentProfileState) _then) = _$CurrentProfileStateCopyWithImpl;
@useResult
$Res call({
 User? user
});




}
/// @nodoc
class _$CurrentProfileStateCopyWithImpl<$Res>
    implements $CurrentProfileStateCopyWith<$Res> {
  _$CurrentProfileStateCopyWithImpl(this._self, this._then);

  final CurrentProfileState _self;
  final $Res Function(CurrentProfileState) _then;

/// Create a copy of CurrentProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}

}



/// @nodoc


class _CurrentProfileState implements CurrentProfileState {
  const _CurrentProfileState({this.user});
  

@override final  User? user;

/// Create a copy of CurrentProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentProfileStateCopyWith<_CurrentProfileState> get copyWith => __$CurrentProfileStateCopyWithImpl<_CurrentProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentProfileState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'CurrentProfileState(user: $user)';
}


}

/// @nodoc
abstract mixin class _$CurrentProfileStateCopyWith<$Res> implements $CurrentProfileStateCopyWith<$Res> {
  factory _$CurrentProfileStateCopyWith(_CurrentProfileState value, $Res Function(_CurrentProfileState) _then) = __$CurrentProfileStateCopyWithImpl;
@override @useResult
$Res call({
 User? user
});




}
/// @nodoc
class __$CurrentProfileStateCopyWithImpl<$Res>
    implements _$CurrentProfileStateCopyWith<$Res> {
  __$CurrentProfileStateCopyWithImpl(this._self, this._then);

  final _CurrentProfileState _self;
  final $Res Function(_CurrentProfileState) _then;

/// Create a copy of CurrentProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(_CurrentProfileState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}


}

// dart format on
