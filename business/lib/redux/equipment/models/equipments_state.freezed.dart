// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EquipmentsState {

 IMap<String, Equipment> get table; IList<String> get view;
/// Create a copy of EquipmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipmentsStateCopyWith<EquipmentsState> get copyWith => _$EquipmentsStateCopyWithImpl<EquipmentsState>(this as EquipmentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipmentsState&&(identical(other.table, table) || other.table == table)&&const DeepCollectionEquality().equals(other.view, view));
}


@override
int get hashCode => Object.hash(runtimeType,table,const DeepCollectionEquality().hash(view));

@override
String toString() {
  return 'EquipmentsState(table: $table, view: $view)';
}


}

/// @nodoc
abstract mixin class $EquipmentsStateCopyWith<$Res>  {
  factory $EquipmentsStateCopyWith(EquipmentsState value, $Res Function(EquipmentsState) _then) = _$EquipmentsStateCopyWithImpl;
@useResult
$Res call({
 IMap<String, Equipment> table, IList<String> view
});




}
/// @nodoc
class _$EquipmentsStateCopyWithImpl<$Res>
    implements $EquipmentsStateCopyWith<$Res> {
  _$EquipmentsStateCopyWithImpl(this._self, this._then);

  final EquipmentsState _self;
  final $Res Function(EquipmentsState) _then;

/// Create a copy of EquipmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? table = null,Object? view = null,}) {
  return _then(_self.copyWith(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, Equipment>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}

}



/// @nodoc


class _EquipmentsState implements EquipmentsState {
  const _EquipmentsState({this.table = const IMapConst<String, Equipment>({}), this.view = const IListConst<String>([])});
  

@override@JsonKey() final  IMap<String, Equipment> table;
@override@JsonKey() final  IList<String> view;

/// Create a copy of EquipmentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipmentsStateCopyWith<_EquipmentsState> get copyWith => __$EquipmentsStateCopyWithImpl<_EquipmentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipmentsState&&(identical(other.table, table) || other.table == table)&&const DeepCollectionEquality().equals(other.view, view));
}


@override
int get hashCode => Object.hash(runtimeType,table,const DeepCollectionEquality().hash(view));

@override
String toString() {
  return 'EquipmentsState(table: $table, view: $view)';
}


}

/// @nodoc
abstract mixin class _$EquipmentsStateCopyWith<$Res> implements $EquipmentsStateCopyWith<$Res> {
  factory _$EquipmentsStateCopyWith(_EquipmentsState value, $Res Function(_EquipmentsState) _then) = __$EquipmentsStateCopyWithImpl;
@override @useResult
$Res call({
 IMap<String, Equipment> table, IList<String> view
});




}
/// @nodoc
class __$EquipmentsStateCopyWithImpl<$Res>
    implements _$EquipmentsStateCopyWith<$Res> {
  __$EquipmentsStateCopyWithImpl(this._self, this._then);

  final _EquipmentsState _self;
  final $Res Function(_EquipmentsState) _then;

/// Create a copy of EquipmentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? table = null,Object? view = null,}) {
  return _then(_EquipmentsState(
table: null == table ? _self.table : table // ignore: cast_nullable_to_non_nullable
as IMap<String, Equipment>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as IList<String>,
  ));
}


}

// dart format on
