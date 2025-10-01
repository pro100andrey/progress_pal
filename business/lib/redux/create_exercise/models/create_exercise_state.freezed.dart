// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_exercise_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateExerciseState {

 String? get title; IList<String> get muscleGroupIds; String? get equipmentId; String? get recordingTypeId; String? get instructions;
/// Create a copy of CreateExerciseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateExerciseStateCopyWith<CreateExerciseState> get copyWith => _$CreateExerciseStateCopyWithImpl<CreateExerciseState>(this as CreateExerciseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateExerciseState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.muscleGroupIds, muscleGroupIds)&&(identical(other.equipmentId, equipmentId) || other.equipmentId == equipmentId)&&(identical(other.recordingTypeId, recordingTypeId) || other.recordingTypeId == recordingTypeId)&&(identical(other.instructions, instructions) || other.instructions == instructions));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(muscleGroupIds),equipmentId,recordingTypeId,instructions);

@override
String toString() {
  return 'CreateExerciseState(title: $title, muscleGroupIds: $muscleGroupIds, equipmentId: $equipmentId, recordingTypeId: $recordingTypeId, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $CreateExerciseStateCopyWith<$Res>  {
  factory $CreateExerciseStateCopyWith(CreateExerciseState value, $Res Function(CreateExerciseState) _then) = _$CreateExerciseStateCopyWithImpl;
@useResult
$Res call({
 String? title, IList<String> muscleGroupIds, String? equipmentId, String? recordingTypeId, String? instructions
});




}
/// @nodoc
class _$CreateExerciseStateCopyWithImpl<$Res>
    implements $CreateExerciseStateCopyWith<$Res> {
  _$CreateExerciseStateCopyWithImpl(this._self, this._then);

  final CreateExerciseState _self;
  final $Res Function(CreateExerciseState) _then;

/// Create a copy of CreateExerciseState
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


class _CreateExerciseState implements CreateExerciseState {
  const _CreateExerciseState({this.title, this.muscleGroupIds = const IListConst<String>([]), this.equipmentId, this.recordingTypeId, this.instructions});
  

@override final  String? title;
@override@JsonKey() final  IList<String> muscleGroupIds;
@override final  String? equipmentId;
@override final  String? recordingTypeId;
@override final  String? instructions;

/// Create a copy of CreateExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateExerciseStateCopyWith<_CreateExerciseState> get copyWith => __$CreateExerciseStateCopyWithImpl<_CreateExerciseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateExerciseState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.muscleGroupIds, muscleGroupIds)&&(identical(other.equipmentId, equipmentId) || other.equipmentId == equipmentId)&&(identical(other.recordingTypeId, recordingTypeId) || other.recordingTypeId == recordingTypeId)&&(identical(other.instructions, instructions) || other.instructions == instructions));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(muscleGroupIds),equipmentId,recordingTypeId,instructions);

@override
String toString() {
  return 'CreateExerciseState(title: $title, muscleGroupIds: $muscleGroupIds, equipmentId: $equipmentId, recordingTypeId: $recordingTypeId, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class _$CreateExerciseStateCopyWith<$Res> implements $CreateExerciseStateCopyWith<$Res> {
  factory _$CreateExerciseStateCopyWith(_CreateExerciseState value, $Res Function(_CreateExerciseState) _then) = __$CreateExerciseStateCopyWithImpl;
@override @useResult
$Res call({
 String? title, IList<String> muscleGroupIds, String? equipmentId, String? recordingTypeId, String? instructions
});




}
/// @nodoc
class __$CreateExerciseStateCopyWithImpl<$Res>
    implements _$CreateExerciseStateCopyWith<$Res> {
  __$CreateExerciseStateCopyWithImpl(this._self, this._then);

  final _CreateExerciseState _self;
  final $Res Function(_CreateExerciseState) _then;

/// Create a copy of CreateExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? muscleGroupIds = null,Object? equipmentId = freezed,Object? recordingTypeId = freezed,Object? instructions = freezed,}) {
  return _then(_CreateExerciseState(
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
