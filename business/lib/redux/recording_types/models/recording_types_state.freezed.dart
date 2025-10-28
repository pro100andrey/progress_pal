// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording_types_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordingTypesState {

 IMap<String, RecordingType> get table; IList<String> get view;
/// Create a copy of RecordingTypesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingTypesStateCopyWith<RecordingTypesState> get copyWith => _$RecordingTypesStateCopyWithImpl<RecordingTypesState>(this as RecordingTypesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingTypesState&&(identical(other.table, table) || other.table == table)&&const DeepCollectionEquality().equals(other.view, view));
}


@override
int get hashCode => Object.hash(runtimeType,table,const DeepCollectionEquality().hash(view));

@override
String toString() {
  return 'RecordingTypesState(table: $table, view: $view)';
}


}

/// @nodoc
abstract mixin class $RecordingTypesStateCopyWith<$Res>  {
  factory $RecordingTypesStateCopyWith(RecordingTypesState value, $Res Function(RecordingTypesState) _then) = _$RecordingTypesStateCopyWithImpl;
@useResult
$Res call({
 IMap<String, RecordingType> table, IList<String> view
});




}
/// @nodoc
class _$RecordingTypesStateCopyWithImpl<$Res>
    implements $RecordingTypesStateCopyWith<$Res> {
  _$RecordingTypesStateCopyWithImpl(this._self, this._then);

  final RecordingTypesState _self;
  final $Res Function(RecordingTypesState) _then;

/// Create a copy of RecordingTypesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? table = null,Object? view = null,}) {
  return _then(_self.copyWith(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, RecordingType>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}

}



/// @nodoc


class _RecordingTypesState implements RecordingTypesState {
  const _RecordingTypesState({this.table = const IMapConst<String, RecordingType>({}), this.view = const IListConst<String>([])});
  

@override@JsonKey() final  IMap<String, RecordingType> table;
@override@JsonKey() final  IList<String> view;

/// Create a copy of RecordingTypesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordingTypesStateCopyWith<_RecordingTypesState> get copyWith => __$RecordingTypesStateCopyWithImpl<_RecordingTypesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordingTypesState&&(identical(other.table, table) || other.table == table)&&const DeepCollectionEquality().equals(other.view, view));
}


@override
int get hashCode => Object.hash(runtimeType,table,const DeepCollectionEquality().hash(view));

@override
String toString() {
  return 'RecordingTypesState(table: $table, view: $view)';
}


}

/// @nodoc
abstract mixin class _$RecordingTypesStateCopyWith<$Res> implements $RecordingTypesStateCopyWith<$Res> {
  factory _$RecordingTypesStateCopyWith(_RecordingTypesState value, $Res Function(_RecordingTypesState) _then) = __$RecordingTypesStateCopyWithImpl;
@override @useResult
$Res call({
 IMap<String, RecordingType> table, IList<String> view
});




}
/// @nodoc
class __$RecordingTypesStateCopyWithImpl<$Res>
    implements _$RecordingTypesStateCopyWith<$Res> {
  __$RecordingTypesStateCopyWithImpl(this._self, this._then);

  final _RecordingTypesState _self;
  final $Res Function(_RecordingTypesState) _then;

/// Create a copy of RecordingTypesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? table = null,Object? view = null,}) {
  return _then(_RecordingTypesState(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, RecordingType>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}


}

// dart format on
