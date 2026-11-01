// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_snapshot_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DemoSnapshotEntity {

 List<ProductEntity> get products; List<OrderEntity> get orders;/// Mobiles whose reorder reminder was marked «ارسال کردم».
 List<String> get sent;
/// Create a copy of DemoSnapshotEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DemoSnapshotEntityCopyWith<DemoSnapshotEntity> get copyWith => _$DemoSnapshotEntityCopyWithImpl<DemoSnapshotEntity>(this as DemoSnapshotEntity, _$identity);

  /// Serializes this DemoSnapshotEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DemoSnapshotEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DemoSnapshotEntity&&const DeepCollectionEquality().equals(other.products, _this.products)&&const DeepCollectionEquality().equals(other.orders, _this.orders)&&const DeepCollectionEquality().equals(other.sent, _this.sent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DemoSnapshotEntity;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.products),const DeepCollectionEquality().hash(_this.orders),const DeepCollectionEquality().hash(_this.sent));
}

@override
String toString() {
  final _this = this as DemoSnapshotEntity;
  return 'DemoSnapshotEntity(products: ${_this.products}, orders: ${_this.orders}, sent: ${_this.sent})';
}


}

/// @nodoc
abstract mixin class $DemoSnapshotEntityCopyWith<$Res>  {
  factory $DemoSnapshotEntityCopyWith(DemoSnapshotEntity value, $Res Function(DemoSnapshotEntity) _then) = _$DemoSnapshotEntityCopyWithImpl;
@useResult
$Res call({
 List<ProductEntity> products, List<OrderEntity> orders, List<String> sent
});




}
/// @nodoc
class _$DemoSnapshotEntityCopyWithImpl<$Res>
    implements $DemoSnapshotEntityCopyWith<$Res> {
  _$DemoSnapshotEntityCopyWithImpl(this._self, this._then);

  final DemoSnapshotEntity _self;
  final $Res Function(DemoSnapshotEntity) _then;

/// Create a copy of DemoSnapshotEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? orders = null,Object? sent = null,}) {
  return _then(DemoSnapshotEntity(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DemoSnapshotEntity].
extension DemoSnapshotEntityPatterns on DemoSnapshotEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DemoSnapshotEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DemoSnapshotEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DemoSnapshotEntity value)  $default,){
final _that = this;
switch (_that) {
case _DemoSnapshotEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DemoSnapshotEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DemoSnapshotEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductEntity> products,  List<OrderEntity> orders,  List<String> sent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DemoSnapshotEntity() when $default != null:
return $default(_that.products,_that.orders,_that.sent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductEntity> products,  List<OrderEntity> orders,  List<String> sent)  $default,) {final _that = this;
switch (_that) {
case _DemoSnapshotEntity():
return $default(_that.products,_that.orders,_that.sent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductEntity> products,  List<OrderEntity> orders,  List<String> sent)?  $default,) {final _that = this;
switch (_that) {
case _DemoSnapshotEntity() when $default != null:
return $default(_that.products,_that.orders,_that.sent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DemoSnapshotEntity implements DemoSnapshotEntity {
  const _DemoSnapshotEntity({required  List<ProductEntity> products, required  List<OrderEntity> orders,  List<String> sent = const <String>[]}): _products = products,_orders = orders,_sent = sent;
  factory _DemoSnapshotEntity.fromJson(Map<String, dynamic> json) => _$DemoSnapshotEntityFromJson(json);

 final  List<ProductEntity> _products;
@override List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<OrderEntity> _orders;
@override List<OrderEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

/// Mobiles whose reorder reminder was marked «ارسال کردم».
 final  List<String> _sent;
/// Mobiles whose reorder reminder was marked «ارسال کردم».
@override@JsonKey() List<String> get sent {
  if (_sent is EqualUnmodifiableListView) return _sent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sent);
}


/// Create a copy of DemoSnapshotEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DemoSnapshotEntityCopyWith<_DemoSnapshotEntity> get copyWith => __$DemoSnapshotEntityCopyWithImpl<_DemoSnapshotEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DemoSnapshotEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DemoSnapshotEntity&&const DeepCollectionEquality().equals(other.products, _products)&&const DeepCollectionEquality().equals(other.orders, _orders)&&const DeepCollectionEquality().equals(other.sent, _sent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_orders),const DeepCollectionEquality().hash(_sent));
}

@override
String toString() {
    return 'DemoSnapshotEntity(products: $products, orders: $orders, sent: $sent)';
}


}

/// @nodoc
abstract mixin class _$DemoSnapshotEntityCopyWith<$Res> implements $DemoSnapshotEntityCopyWith<$Res> {
  factory _$DemoSnapshotEntityCopyWith(_DemoSnapshotEntity value, $Res Function(_DemoSnapshotEntity) _then) = __$DemoSnapshotEntityCopyWithImpl;
@override @useResult
$Res call({
 List<ProductEntity> products, List<OrderEntity> orders, List<String> sent
});




}
/// @nodoc
class __$DemoSnapshotEntityCopyWithImpl<$Res>
    implements _$DemoSnapshotEntityCopyWith<$Res> {
  __$DemoSnapshotEntityCopyWithImpl(this._self, this._then);

  final _DemoSnapshotEntity _self;
  final $Res Function(_DemoSnapshotEntity) _then;

/// Create a copy of DemoSnapshotEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? orders = null,Object? sent = null,}) {
  return _then(_DemoSnapshotEntity(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,sent: null == sent ? _self._sent : sent // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
