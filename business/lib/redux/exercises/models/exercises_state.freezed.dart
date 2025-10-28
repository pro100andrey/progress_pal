// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercises_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExercisesState {

 IMap<String, Exercise> get table;
/// Create a copy of ExercisesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisesStateCopyWith<ExercisesState> get copyWith => _$ExercisesStateCopyWithImpl<ExercisesState>(this as ExercisesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisesState&&(identical(other.table, table) || other.table == table));
}


@override
int get hashCode => Object.hash(runtimeType,table);

@override
String toString() {
  return 'ExercisesState(table: $table)';
}


}

/// @nodoc
abstract mixin class $ExercisesStateCopyWith<$Res>  {
  factory $ExercisesStateCopyWith(ExercisesState value, $Res Function(ExercisesState) _then) = _$ExercisesStateCopyWithImpl;
@useResult
$Res call({
 IMap<String, Exercise> table
});




}
/// @nodoc
class _$ExercisesStateCopyWithImpl<$Res>
    implements $ExercisesStateCopyWith<$Res> {
  _$ExercisesStateCopyWithImpl(this._self, this._then);

  final ExercisesState _self;
  final $Res Function(ExercisesState) _then;

/// Create a copy of ExercisesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? table = null,}) {
  return _then(_self.copyWith(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, Exercise>,
  ));
}

}



/// @nodoc


class _ExercisesState implements ExercisesState {
  const _ExercisesState({this.table = const IMapConst<String, Exercise>({})});
  

@override@JsonKey() final  IMap<String, Exercise> table;

/// Create a copy of ExercisesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExercisesStateCopyWith<_ExercisesState> get copyWith => __$ExercisesStateCopyWithImpl<_ExercisesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExercisesState&&(identical(other.table, table) || other.table == table));
}


@override
int get hashCode => Object.hash(runtimeType,table);

@override
String toString() {
  return 'ExercisesState(table: $table)';
}


}

/// @nodoc
abstract mixin class _$ExercisesStateCopyWith<$Res> implements $ExercisesStateCopyWith<$Res> {
  factory _$ExercisesStateCopyWith(_ExercisesState value, $Res Function(_ExercisesState) _then) = __$ExercisesStateCopyWithImpl;
@override @useResult
$Res call({
 IMap<String, Exercise> table
});




}
/// @nodoc
class __$ExercisesStateCopyWithImpl<$Res>
    implements _$ExercisesStateCopyWith<$Res> {
  __$ExercisesStateCopyWithImpl(this._self, this._then);

  final _ExercisesState _self;
  final $Res Function(_ExercisesState) _then;

/// Create a copy of ExercisesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? table = null,}) {
  return _then(_ExercisesState(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, Exercise>,
  ));
}


}

// dart format on
