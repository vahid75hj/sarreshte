// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerDetailEntity {

/// All orders of this customer, newest first (including cancelled).
 List<OrderEntity> get orders; int get validCount; int get spent; String get topProduct;/// null when the customer has no rated order.
 double? get avgRating; int get ratedCount; String get instagram;
/// Create a copy of CustomerDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerDetailEntityCopyWith<CustomerDetailEntity> get copyWith => _$CustomerDetailEntityCopyWithImpl<CustomerDetailEntity>(this as CustomerDetailEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CustomerDetailEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerDetailEntity&&const DeepCollectionEquality().equals(other.orders, _this.orders)&&(identical(other.validCount, _this.validCount) || other.validCount == _this.validCount)&&(identical(other.spent, _this.spent) || other.spent == _this.spent)&&(identical(other.topProduct, _this.topProduct) || other.topProduct == _this.topProduct)&&(identical(other.avgRating, _this.avgRating) || other.avgRating == _this.avgRating)&&(identical(other.ratedCount, _this.ratedCount) || other.ratedCount == _this.ratedCount)&&(identical(other.instagram, _this.instagram) || other.instagram == _this.instagram));
}


@override
int get hashCode {
  final _this = this as CustomerDetailEntity;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.orders),_this.validCount,_this.spent,_this.topProduct,_this.avgRating,_this.ratedCount,_this.instagram);
}

@override
String toString() {
  final _this = this as CustomerDetailEntity;
  return 'CustomerDetailEntity(orders: ${_this.orders}, validCount: ${_this.validCount}, spent: ${_this.spent}, topProduct: ${_this.topProduct}, avgRating: ${_this.avgRating}, ratedCount: ${_this.ratedCount}, instagram: ${_this.instagram})';
}


}

/// @nodoc
abstract mixin class $CustomerDetailEntityCopyWith<$Res>  {
  factory $CustomerDetailEntityCopyWith(CustomerDetailEntity value, $Res Function(CustomerDetailEntity) _then) = _$CustomerDetailEntityCopyWithImpl;
@useResult
$Res call({
 List<OrderEntity> orders, int validCount, int spent, String topProduct, double? avgRating, int ratedCount, String instagram
});




}
/// @nodoc
class _$CustomerDetailEntityCopyWithImpl<$Res>
    implements $CustomerDetailEntityCopyWith<$Res> {
  _$CustomerDetailEntityCopyWithImpl(this._self, this._then);

  final CustomerDetailEntity _self;
  final $Res Function(CustomerDetailEntity) _then;

/// Create a copy of CustomerDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orders = null,Object? validCount = null,Object? spent = null,Object? topProduct = null,Object? avgRating = freezed,Object? ratedCount = null,Object? instagram = null,}) {
  return _then(CustomerDetailEntity(
orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,validCount: null == validCount ? _self.validCount : validCount // ignore: cast_nullable_to_non_nullable
as int,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as int,topProduct: null == topProduct ? _self.topProduct : topProduct // ignore: cast_nullable_to_non_nullable
as String,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,ratedCount: null == ratedCount ? _self.ratedCount : ratedCount // ignore: cast_nullable_to_non_nullable
as int,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerDetailEntity].
extension CustomerDetailEntityPatterns on CustomerDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _CustomerDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OrderEntity> orders,  int validCount,  int spent,  String topProduct,  double? avgRating,  int ratedCount,  String instagram)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerDetailEntity() when $default != null:
return $default(_that.orders,_that.validCount,_that.spent,_that.topProduct,_that.avgRating,_that.ratedCount,_that.instagram);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OrderEntity> orders,  int validCount,  int spent,  String topProduct,  double? avgRating,  int ratedCount,  String instagram)  $default,) {final _that = this;
switch (_that) {
case _CustomerDetailEntity():
return $default(_that.orders,_that.validCount,_that.spent,_that.topProduct,_that.avgRating,_that.ratedCount,_that.instagram);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OrderEntity> orders,  int validCount,  int spent,  String topProduct,  double? avgRating,  int ratedCount,  String instagram)?  $default,) {final _that = this;
switch (_that) {
case _CustomerDetailEntity() when $default != null:
return $default(_that.orders,_that.validCount,_that.spent,_that.topProduct,_that.avgRating,_that.ratedCount,_that.instagram);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerDetailEntity implements CustomerDetailEntity {
  const _CustomerDetailEntity({required  List<OrderEntity> orders, required this.validCount, required this.spent, required this.topProduct, this.avgRating, required this.ratedCount, required this.instagram}): _orders = orders;
  

/// All orders of this customer, newest first (including cancelled).
 final  List<OrderEntity> _orders;
/// All orders of this customer, newest first (including cancelled).
@override List<OrderEntity> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

@override final  int validCount;
@override final  int spent;
@override final  String topProduct;
/// null when the customer has no rated order.
@override final  double? avgRating;
@override final  int ratedCount;
@override final  String instagram;

/// Create a copy of CustomerDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerDetailEntityCopyWith<_CustomerDetailEntity> get copyWith => __$CustomerDetailEntityCopyWithImpl<_CustomerDetailEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerDetailEntity&&const DeepCollectionEquality().equals(other.orders, _orders)&&(identical(other.validCount, validCount) || other.validCount == validCount)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.topProduct, topProduct) || other.topProduct == topProduct)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating)&&(identical(other.ratedCount, ratedCount) || other.ratedCount == ratedCount)&&(identical(other.instagram, instagram) || other.instagram == instagram));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),validCount,spent,topProduct,avgRating,ratedCount,instagram);
}

@override
String toString() {
    return 'CustomerDetailEntity(orders: $orders, validCount: $validCount, spent: $spent, topProduct: $topProduct, avgRating: $avgRating, ratedCount: $ratedCount, instagram: $instagram)';
}


}

/// @nodoc
abstract mixin class _$CustomerDetailEntityCopyWith<$Res> implements $CustomerDetailEntityCopyWith<$Res> {
  factory _$CustomerDetailEntityCopyWith(_CustomerDetailEntity value, $Res Function(_CustomerDetailEntity) _then) = __$CustomerDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 List<OrderEntity> orders, int validCount, int spent, String topProduct, double? avgRating, int ratedCount, String instagram
});




}
/// @nodoc
class __$CustomerDetailEntityCopyWithImpl<$Res>
    implements _$CustomerDetailEntityCopyWith<$Res> {
  __$CustomerDetailEntityCopyWithImpl(this._self, this._then);

  final _CustomerDetailEntity _self;
  final $Res Function(_CustomerDetailEntity) _then;

/// Create a copy of CustomerDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orders = null,Object? validCount = null,Object? spent = null,Object? topProduct = null,Object? avgRating = freezed,Object? ratedCount = null,Object? instagram = null,}) {
  return _then(_CustomerDetailEntity(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderEntity>,validCount: null == validCount ? _self.validCount : validCount // ignore: cast_nullable_to_non_nullable
as int,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as int,topProduct: null == topProduct ? _self.topProduct : topProduct // ignore: cast_nullable_to_non_nullable
as String,avgRating: freezed == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double?,ratedCount: null == ratedCount ? _self.ratedCount : ratedCount // ignore: cast_nullable_to_non_nullable
as int,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
