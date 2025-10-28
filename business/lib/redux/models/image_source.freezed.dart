// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageSource {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSource);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageSource()';
}


}

/// @nodoc
class $ImageSourceCopyWith<$Res>  {
$ImageSourceCopyWith(ImageSource _, $Res Function(ImageSource) __);
}



/// @nodoc


class NoneImageSource implements ImageSource {
  const NoneImageSource();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoneImageSource);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageSource.none()';
}


}




/// @nodoc


class NetworkImageSource implements ImageSource {
  const NetworkImageSource({required this.url, required this.name});
  

 final  String url;
 final  String name;

/// Create a copy of ImageSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkImageSourceCopyWith<NetworkImageSource> get copyWith => _$NetworkImageSourceCopyWithImpl<NetworkImageSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkImageSource&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,url,name);

@override
String toString() {
  return 'ImageSource.network(url: $url, name: $name)';
}


}

/// @nodoc
abstract mixin class $NetworkImageSourceCopyWith<$Res> implements $ImageSourceCopyWith<$Res> {
  factory $NetworkImageSourceCopyWith(NetworkImageSource value, $Res Function(NetworkImageSource) _then) = _$NetworkImageSourceCopyWithImpl;
@useResult
$Res call({
 String url, String name
});




}
/// @nodoc
class _$NetworkImageSourceCopyWithImpl<$Res>
    implements $NetworkImageSourceCopyWith<$Res> {
  _$NetworkImageSourceCopyWithImpl(this._self, this._then);

  final NetworkImageSource _self;
  final $Res Function(NetworkImageSource) _then;

/// Create a copy of ImageSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? name = null,}) {
  return _then(NetworkImageSource(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MemoryImageSource implements ImageSource {
  const MemoryImageSource({required this.bytes, required this.name});
  

 final  Uint8List bytes;
 final  String name;

/// Create a copy of ImageSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryImageSourceCopyWith<MemoryImageSource> get copyWith => _$MemoryImageSourceCopyWithImpl<MemoryImageSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryImageSource&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),name);

@override
String toString() {
  return 'ImageSource.memory(bytes: $bytes, name: $name)';
}


}

/// @nodoc
abstract mixin class $MemoryImageSourceCopyWith<$Res> implements $ImageSourceCopyWith<$Res> {
  factory $MemoryImageSourceCopyWith(MemoryImageSource value, $Res Function(MemoryImageSource) _then) = _$MemoryImageSourceCopyWithImpl;
@useResult
$Res call({
 Uint8List bytes, String name
});




}
/// @nodoc
class _$MemoryImageSourceCopyWithImpl<$Res>
    implements $MemoryImageSourceCopyWith<$Res> {
  _$MemoryImageSourceCopyWithImpl(this._self, this._then);

  final MemoryImageSource _self;
  final $Res Function(MemoryImageSource) _then;

/// Create a copy of ImageSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? name = null,}) {
  return _then(MemoryImageSource(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
