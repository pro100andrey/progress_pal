// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_db_exercise_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateDbExerciseState {

 IMap<String, String?>? get title; IList<String> get muscleGroupIds; String? get equipmentId; String? get recordingTypeId; IMap<String, Delta?>? get instructions; IList<MemoryImageSource> get images;
/// Create a copy of CreateDbExerciseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateDbExerciseStateCopyWith<CreateDbExerciseState> get copyWith => _$CreateDbExerciseStateCopyWithImpl<CreateDbExerciseState>(this as CreateDbExerciseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateDbExerciseState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.muscleGroupIds, muscleGroupIds)&&(identical(other.equipmentId, equipmentId) || other.equipmentId == equipmentId)&&(identical(other.recordingTypeId, recordingTypeId) || other.recordingTypeId == recordingTypeId)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&const DeepCollectionEquality().equals(other.images, images));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(muscleGroupIds),equipmentId,recordingTypeId,instructions,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'CreateDbExerciseState(title: $title, muscleGroupIds: $muscleGroupIds, equipmentId: $equipmentId, recordingTypeId: $recordingTypeId, instructions: $instructions, images: $images)';
}


}

/// @nodoc
abstract mixin class $CreateDbExerciseStateCopyWith<$Res>  {
  factory $CreateDbExerciseStateCopyWith(CreateDbExerciseState value, $Res Function(CreateDbExerciseState) _then) = _$CreateDbExerciseStateCopyWithImpl;
@useResult
$Res call({
 IMap<String, String?>? title, IList<String> muscleGroupIds, String? equipmentId, String? recordingTypeId, IMap<String, Delta?>? instructions, IList<MemoryImageSource> images
});




}
/// @nodoc
class _$CreateDbExerciseStateCopyWithImpl<$Res>
    implements $CreateDbExerciseStateCopyWith<$Res> {
  _$CreateDbExerciseStateCopyWithImpl(this._self, this._then);

  final CreateDbExerciseState _self;
  final $Res Function(CreateDbExerciseState) _then;

/// Create a copy of CreateDbExerciseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? muscleGroupIds = null,Object? equipmentId = freezed,Object? recordingTypeId = freezed,Object? instructions = freezed,Object? images = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as IMap<String, String?>?,muscleGroupIds: null == muscleGroupIds ? _self.muscleGroupIds : muscleGroupIds // ignore: cast_nullable_to_non_nullable
as IList<String>,equipmentId: freezed == equipmentId ? _self.equipmentId : equipmentId // ignore: cast_nullable_to_non_nullable
as String?,recordingTypeId: freezed == recordingTypeId ? _self.recordingTypeId : recordingTypeId // ignore: cast_nullable_to_non_nullable
as String?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as IMap<String, Delta?>?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as IList<MemoryImageSource>,
  ));
}

}



/// @nodoc


class _CreateDbExerciseState implements CreateDbExerciseState {
  const _CreateDbExerciseState({this.title, this.muscleGroupIds = const IListConst<String>([]), this.equipmentId, this.recordingTypeId, this.instructions, this.images = const IListConst<MemoryImageSource>([])});
  

@override final  IMap<String, String?>? title;
@override@JsonKey() final  IList<String> muscleGroupIds;
@override final  String? equipmentId;
@override final  String? recordingTypeId;
@override final  IMap<String, Delta?>? instructions;
@override@JsonKey() final  IList<MemoryImageSource> images;

/// Create a copy of CreateDbExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateDbExerciseStateCopyWith<_CreateDbExerciseState> get copyWith => __$CreateDbExerciseStateCopyWithImpl<_CreateDbExerciseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateDbExerciseState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.muscleGroupIds, muscleGroupIds)&&(identical(other.equipmentId, equipmentId) || other.equipmentId == equipmentId)&&(identical(other.recordingTypeId, recordingTypeId) || other.recordingTypeId == recordingTypeId)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&const DeepCollectionEquality().equals(other.images, images));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(muscleGroupIds),equipmentId,recordingTypeId,instructions,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'CreateDbExerciseState(title: $title, muscleGroupIds: $muscleGroupIds, equipmentId: $equipmentId, recordingTypeId: $recordingTypeId, instructions: $instructions, images: $images)';
}


}

/// @nodoc
abstract mixin class _$CreateDbExerciseStateCopyWith<$Res> implements $CreateDbExerciseStateCopyWith<$Res> {
  factory _$CreateDbExerciseStateCopyWith(_CreateDbExerciseState value, $Res Function(_CreateDbExerciseState) _then) = __$CreateDbExerciseStateCopyWithImpl;
@override @useResult
$Res call({
 IMap<String, String?>? title, IList<String> muscleGroupIds, String? equipmentId, String? recordingTypeId, IMap<String, Delta?>? instructions, IList<MemoryImageSource> images
});




}
/// @nodoc
class __$CreateDbExerciseStateCopyWithImpl<$Res>
    implements _$CreateDbExerciseStateCopyWith<$Res> {
  __$CreateDbExerciseStateCopyWithImpl(this._self, this._then);

  final _CreateDbExerciseState _self;
  final $Res Function(_CreateDbExerciseState) _then;

/// Create a copy of CreateDbExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? muscleGroupIds = null,Object? equipmentId = freezed,Object? recordingTypeId = freezed,Object? instructions = freezed,Object? images = null,}) {
  return _then(_CreateDbExerciseState(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as IMap<String, String?>?,muscleGroupIds: null == muscleGroupIds ? _self.muscleGroupIds : muscleGroupIds // ignore: cast_nullable_to_non_nullable
as IList<String>,equipmentId: freezed == equipmentId ? _self.equipmentId : equipmentId // ignore: cast_nullable_to_non_nullable
as String?,recordingTypeId: freezed == recordingTypeId ? _self.recordingTypeId : recordingTypeId // ignore: cast_nullable_to_non_nullable
as String?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as IMap<String, Delta?>?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as IList<MemoryImageSource>,
  ));
}


}

// dart format on
