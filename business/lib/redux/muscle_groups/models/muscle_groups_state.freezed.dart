// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'muscle_groups_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MuscleGroupsState {

 IMap<String, MuscleGroup> get table; IList<String> get view;
/// Create a copy of MuscleGroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuscleGroupsStateCopyWith<MuscleGroupsState> get copyWith => _$MuscleGroupsStateCopyWithImpl<MuscleGroupsState>(this as MuscleGroupsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuscleGroupsState&&(identical(other.table, table) || other.table == table)&&const DeepCollectionEquality().equals(other.view, view));
}


@override
int get hashCode => Object.hash(runtimeType,table,const DeepCollectionEquality().hash(view));

@override
String toString() {
  return 'MuscleGroupsState(table: $table, view: $view)';
}


}

/// @nodoc
abstract mixin class $MuscleGroupsStateCopyWith<$Res>  {
  factory $MuscleGroupsStateCopyWith(MuscleGroupsState value, $Res Function(MuscleGroupsState) _then) = _$MuscleGroupsStateCopyWithImpl;
@useResult
$Res call({
 IMap<String, MuscleGroup> table, IList<String> view
});




}
/// @nodoc
class _$MuscleGroupsStateCopyWithImpl<$Res>
    implements $MuscleGroupsStateCopyWith<$Res> {
  _$MuscleGroupsStateCopyWithImpl(this._self, this._then);

  final MuscleGroupsState _self;
  final $Res Function(MuscleGroupsState) _then;

/// Create a copy of MuscleGroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? table = null,Object? view = null,}) {
  return _then(_self.copyWith(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, MuscleGroup>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}

}



/// @nodoc


class _MuscleGroupsState implements MuscleGroupsState {
  const _MuscleGroupsState({this.table = const IMapConst<String, MuscleGroup>({}), this.view = const IListConst<String>([])});
  

@override@JsonKey() final  IMap<String, MuscleGroup> table;
@override@JsonKey() final  IList<String> view;

/// Create a copy of MuscleGroupsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuscleGroupsStateCopyWith<_MuscleGroupsState> get copyWith => __$MuscleGroupsStateCopyWithImpl<_MuscleGroupsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuscleGroupsState&&(identical(other.table, table) || other.table == table)&&const DeepCollectionEquality().equals(other.view, view));
}


@override
int get hashCode => Object.hash(runtimeType,table,const DeepCollectionEquality().hash(view));

@override
String toString() {
  return 'MuscleGroupsState(table: $table, view: $view)';
}


}

/// @nodoc
abstract mixin class _$MuscleGroupsStateCopyWith<$Res> implements $MuscleGroupsStateCopyWith<$Res> {
  factory _$MuscleGroupsStateCopyWith(_MuscleGroupsState value, $Res Function(_MuscleGroupsState) _then) = __$MuscleGroupsStateCopyWithImpl;
@override @useResult
$Res call({
 IMap<String, MuscleGroup> table, IList<String> view
});




}
/// @nodoc
class __$MuscleGroupsStateCopyWithImpl<$Res>
    implements _$MuscleGroupsStateCopyWith<$Res> {
  __$MuscleGroupsStateCopyWithImpl(this._self, this._then);

  final _MuscleGroupsState _self;
  final $Res Function(_MuscleGroupsState) _then;

/// Create a copy of MuscleGroupsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? table = null,Object? view = null,}) {
  return _then(_MuscleGroupsState(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, MuscleGroup>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}


}

// dart format on
