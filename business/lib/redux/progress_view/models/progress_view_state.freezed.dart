// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgressViewState {

 DateTime? get selectedDate;
/// Create a copy of ProgressViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressViewStateCopyWith<ProgressViewState> get copyWith => _$ProgressViewStateCopyWithImpl<ProgressViewState>(this as ProgressViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressViewState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate);

@override
String toString() {
  return 'ProgressViewState(selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class $ProgressViewStateCopyWith<$Res>  {
  factory $ProgressViewStateCopyWith(ProgressViewState value, $Res Function(ProgressViewState) _then) = _$ProgressViewStateCopyWithImpl;
@useResult
$Res call({
 DateTime? selectedDate
});




}
/// @nodoc
class _$ProgressViewStateCopyWithImpl<$Res>
    implements $ProgressViewStateCopyWith<$Res> {
  _$ProgressViewStateCopyWithImpl(this._self, this._then);

  final ProgressViewState _self;
  final $Res Function(ProgressViewState) _then;

/// Create a copy of ProgressViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedDate = freezed,}) {
  return _then(_self.copyWith(
selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _ProgressViewState implements ProgressViewState {
  const _ProgressViewState({this.selectedDate});
  

@override final  DateTime? selectedDate;

/// Create a copy of ProgressViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressViewStateCopyWith<_ProgressViewState> get copyWith => __$ProgressViewStateCopyWithImpl<_ProgressViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressViewState&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,selectedDate);

@override
String toString() {
  return 'ProgressViewState(selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class _$ProgressViewStateCopyWith<$Res> implements $ProgressViewStateCopyWith<$Res> {
  factory _$ProgressViewStateCopyWith(_ProgressViewState value, $Res Function(_ProgressViewState) _then) = __$ProgressViewStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? selectedDate
});




}
/// @nodoc
class __$ProgressViewStateCopyWithImpl<$Res>
    implements _$ProgressViewStateCopyWith<$Res> {
  __$ProgressViewStateCopyWithImpl(this._self, this._then);

  final _ProgressViewState _self;
  final $Res Function(_ProgressViewState) _then;

/// Create a copy of ProgressViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedDate = freezed,}) {
  return _then(_ProgressViewState(
selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
