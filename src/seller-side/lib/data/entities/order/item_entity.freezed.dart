// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemEntity {

 String get name; int get price; int get qty;
/// Create a copy of ItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemEntityCopyWith<ItemEntity> get copyWith => _$ItemEntityCopyWithImpl<ItemEntity>(this as ItemEntity, _$identity);

  /// Serializes this ItemEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ItemEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemEntity&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.qty, _this.qty) || other.qty == _this.qty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ItemEntity;
  return Object.hash(runtimeType,_this.name,_this.price,_this.qty);
}

@override
String toString() {
  final _this = this as ItemEntity;
  return 'ItemEntity(name: ${_this.name}, price: ${_this.price}, qty: ${_this.qty})';
}


}

/// @nodoc
abstract mixin class $ItemEntityCopyWith<$Res>  {
  factory $ItemEntityCopyWith(ItemEntity value, $Res Function(ItemEntity) _then) = _$ItemEntityCopyWithImpl;
@useResult
$Res call({
 String name, int price, int qty
});




}
/// @nodoc
class _$ItemEntityCopyWithImpl<$Res>
    implements $ItemEntityCopyWith<$Res> {
  _$ItemEntityCopyWithImpl(this._self, this._then);

  final ItemEntity _self;
  final $Res Function(ItemEntity) _then;

/// Create a copy of ItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? price = null,Object? qty = null,}) {
  return _then(ItemEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemEntity].
extension ItemEntityPatterns on ItemEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _ItemEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ItemEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int price,  int qty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemEntity() when $default != null:
return $default(_that.name,_that.price,_that.qty);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int price,  int qty)  $default,) {final _that = this;
switch (_that) {
case _ItemEntity():
return $default(_that.name,_that.price,_that.qty);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int price,  int qty)?  $default,) {final _that = this;
switch (_that) {
case _ItemEntity() when $default != null:
return $default(_that.name,_that.price,_that.qty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemEntity implements ItemEntity {
  const _ItemEntity({required this.name, required this.price, required this.qty});
  factory _ItemEntity.fromJson(Map<String, dynamic> json) => _$ItemEntityFromJson(json);

@override final  String name;
@override final  int price;
@override final  int qty;

/// Create a copy of ItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemEntityCopyWith<_ItemEntity> get copyWith => __$ItemEntityCopyWithImpl<_ItemEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.qty, qty) || other.qty == qty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,price,qty);
}

@override
String toString() {
    return 'ItemEntity(name: $name, price: $price, qty: $qty)';
}


}

/// @nodoc
abstract mixin class _$ItemEntityCopyWith<$Res> implements $ItemEntityCopyWith<$Res> {
  factory _$ItemEntityCopyWith(_ItemEntity value, $Res Function(_ItemEntity) _then) = __$ItemEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, int price, int qty
});




}
/// @nodoc
class __$ItemEntityCopyWithImpl<$Res>
    implements _$ItemEntityCopyWith<$Res> {
  __$ItemEntityCopyWithImpl(this._self, this._then);

  final _ItemEntity _self;
  final $Res Function(_ItemEntity) _then;

/// Create a copy of ItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? price = null,Object? qty = null,}) {
  return _then(_ItemEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,qty: null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
