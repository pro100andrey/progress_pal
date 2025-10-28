// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_my_exercise_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateMyExerciseState {

 String? get title; IList<String> get muscleGroupIds; String? get equipmentId; String? get recordingTypeId; String? get instructions;
/// Create a copy of CreateMyExerciseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateMyExerciseStateCopyWith<CreateMyExerciseState> get copyWith => _$CreateMyExerciseStateCopyWithImpl<CreateMyExerciseState>(this as CreateMyExerciseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateMyExerciseState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.muscleGroupIds, muscleGroupIds)&&(identical(other.equipmentId, equipmentId) || other.equipmentId == equipmentId)&&(identical(other.recordingTypeId, recordingTypeId) || other.recordingTypeId == recordingTypeId)&&(identical(other.instructions, instructions) || other.instructions == instructions));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(muscleGroupIds),equipmentId,recordingTypeId,instructions);

@override
String toString() {
  return 'CreateMyExerciseState(title: $title, muscleGroupIds: $muscleGroupIds, equipmentId: $equipmentId, recordingTypeId: $recordingTypeId, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $CreateMyExerciseStateCopyWith<$Res>  {
  factory $CreateMyExerciseStateCopyWith(CreateMyExerciseState value, $Res Function(CreateMyExerciseState) _then) = _$CreateMyExerciseStateCopyWithImpl;
@useResult
$Res call({
 String? title, IList<String> muscleGroupIds, String? equipmentId, String? recordingTypeId, String? instructions
});




}
/// @nodoc
class _$CreateMyExerciseStateCopyWithImpl<$Res>
    implements $CreateMyExerciseStateCopyWith<$Res> {
  _$CreateMyExerciseStateCopyWithImpl(this._self, this._then);

  final CreateMyExerciseState _self;
  final $Res Function(CreateMyExerciseState) _then;

/// Create a copy of CreateMyExerciseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? muscleGroupIds = null,Object? equipmentId = freezed,Object? recordingTypeId = freezed,Object? instructions = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,muscleGroupIds: null == muscleGroupIds ? _self.muscleGroupIds : muscleGroupIds // ignore: cast_nullable_to_non_nullable
as IList<String>,equipmentId: freezed == equipmentId ? _self.equipmentId : equipmentId // ignore: cast_nullable_to_non_nullable
as String?,recordingTypeId: freezed == recordingTypeId ? _self.recordingTypeId : recordingTypeId // ignore: cast_nullable_to_non_nullable
as String?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _CreateMyExerciseState implements CreateMyExerciseState {
  const _CreateMyExerciseState({this.title, this.muscleGroupIds = const IListConst<String>([]), this.equipmentId, this.recordingTypeId, this.instructions});
  

@override final  String? title;
@override@JsonKey() final  IList<String> muscleGroupIds;
@override final  String? equipmentId;
@override final  String? recordingTypeId;
@override final  String? instructions;

/// Create a copy of CreateMyExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateMyExerciseStateCopyWith<_CreateMyExerciseState> get copyWith => __$CreateMyExerciseStateCopyWithImpl<_CreateMyExerciseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateMyExerciseState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.muscleGroupIds, muscleGroupIds)&&(identical(other.equipmentId, equipmentId) || other.equipmentId == equipmentId)&&(identical(other.recordingTypeId, recordingTypeId) || other.recordingTypeId == recordingTypeId)&&(identical(other.instructions, instructions) || other.instructions == instructions));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(muscleGroupIds),equipmentId,recordingTypeId,instructions);

@override
String toString() {
  return 'CreateMyExerciseState(title: $title, muscleGroupIds: $muscleGroupIds, equipmentId: $equipmentId, recordingTypeId: $recordingTypeId, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class _$CreateMyExerciseStateCopyWith<$Res> implements $CreateMyExerciseStateCopyWith<$Res> {
  factory _$CreateMyExerciseStateCopyWith(_CreateMyExerciseState value, $Res Function(_CreateMyExerciseState) _then) = __$CreateMyExerciseStateCopyWithImpl;
@override @useResult
$Res call({
 String? title, IList<String> muscleGroupIds, String? equipmentId, String? recordingTypeId, String? instructions
});




}
/// @nodoc
class __$CreateMyExerciseStateCopyWithImpl<$Res>
    implements _$CreateMyExerciseStateCopyWith<$Res> {
  __$CreateMyExerciseStateCopyWithImpl(this._self, this._then);

  final _CreateMyExerciseState _self;
  final $Res Function(_CreateMyExerciseState) _then;

/// Create a copy of CreateMyExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? muscleGroupIds = null,Object? equipmentId = freezed,Object? recordingTypeId = freezed,Object? instructions = freezed,}) {
  return _then(_CreateMyExerciseState(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,muscleGroupIds: null == muscleGroupIds ? _self.muscleGroupIds : muscleGroupIds // ignore: cast_nullable_to_non_nullable
as IList<String>,equipmentId: freezed == equipmentId ? _self.equipmentId : equipmentId // ignore: cast_nullable_to_non_nullable
as String?,recordingTypeId: freezed == recordingTypeId ? _self.recordingTypeId : recordingTypeId // ignore: cast_nullable_to_non_nullable
as String?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
