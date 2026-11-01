// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderEntity {

 int get id; String get code; String get name; String get mobile; String get address; String get note; String get status; String get payRef; String get postalCode; bool get hasReceipt; bool get seen; String get instagram; int get rating; String get comment; DateTime get createdAt; List<ItemEntity> get items;
/// Create a copy of OrderEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderEntityCopyWith<OrderEntity> get copyWith => _$OrderEntityCopyWithImpl<OrderEntity>(this as OrderEntity, _$identity);

  /// Serializes this OrderEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.mobile, _this.mobile) || other.mobile == _this.mobile)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.payRef, _this.payRef) || other.payRef == _this.payRef)&&(identical(other.postalCode, _this.postalCode) || other.postalCode == _this.postalCode)&&(identical(other.hasReceipt, _this.hasReceipt) || other.hasReceipt == _this.hasReceipt)&&(identical(other.seen, _this.seen) || other.seen == _this.seen)&&(identical(other.instagram, _this.instagram) || other.instagram == _this.instagram)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.items, _this.items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderEntity;
  return Object.hash(runtimeType,_this.id,_this.code,_this.name,_this.mobile,_this.address,_this.note,_this.status,_this.payRef,_this.postalCode,_this.hasReceipt,_this.seen,_this.instagram,_this.rating,_this.comment,_this.createdAt,const DeepCollectionEquality().hash(_this.items));
}

@override
String toString() {
  final _this = this as OrderEntity;
  return 'OrderEntity(id: ${_this.id}, code: ${_this.code}, name: ${_this.name}, mobile: ${_this.mobile}, address: ${_this.address}, note: ${_this.note}, status: ${_this.status}, payRef: ${_this.payRef}, postalCode: ${_this.postalCode}, hasReceipt: ${_this.hasReceipt}, seen: ${_this.seen}, instagram: ${_this.instagram}, rating: ${_this.rating}, comment: ${_this.comment}, createdAt: ${_this.createdAt}, items: ${_this.items})';
}


}

/// @nodoc
abstract mixin class $OrderEntityCopyWith<$Res>  {
  factory $OrderEntityCopyWith(OrderEntity value, $Res Function(OrderEntity) _then) = _$OrderEntityCopyWithImpl;
@useResult
$Res call({
 int id, String code, String name, String mobile, String address, String note, String status, String payRef, String postalCode, bool hasReceipt, bool seen, String instagram, int rating, String comment, DateTime createdAt, List<ItemEntity> items
});




}
/// @nodoc
class _$OrderEntityCopyWithImpl<$Res>
    implements $OrderEntityCopyWith<$Res> {
  _$OrderEntityCopyWithImpl(this._self, this._then);

  final OrderEntity _self;
  final $Res Function(OrderEntity) _then;

/// Create a copy of OrderEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? mobile = null,Object? address = null,Object? note = null,Object? status = null,Object? payRef = null,Object? postalCode = null,Object? hasReceipt = null,Object? seen = null,Object? instagram = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? items = null,}) {
  return _then(OrderEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,payRef: null == payRef ? _self.payRef : payRef // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,hasReceipt: null == hasReceipt ? _self.hasReceipt : hasReceipt // ignore: cast_nullable_to_non_nullable
as bool,seen: null == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ItemEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderEntity].
extension OrderEntityPatterns on OrderEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderEntity value)  $default,){
final _that = this;
switch (_that) {
case _OrderEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderEntity value)?  $default,){
final _that = this;
switch (_that) {
case _OrderEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String mobile,  String address,  String note,  String status,  String payRef,  String postalCode,  bool hasReceipt,  bool seen,  String instagram,  int rating,  String comment,  DateTime createdAt,  List<ItemEntity> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderEntity() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.mobile,_that.address,_that.note,_that.status,_that.payRef,_that.postalCode,_that.hasReceipt,_that.seen,_that.instagram,_that.rating,_that.comment,_that.createdAt,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String name,  String mobile,  String address,  String note,  String status,  String payRef,  String postalCode,  bool hasReceipt,  bool seen,  String instagram,  int rating,  String comment,  DateTime createdAt,  List<ItemEntity> items)  $default,) {final _that = this;
switch (_that) {
case _OrderEntity():
return $default(_that.id,_that.code,_that.name,_that.mobile,_that.address,_that.note,_that.status,_that.payRef,_that.postalCode,_that.hasReceipt,_that.seen,_that.instagram,_that.rating,_that.comment,_that.createdAt,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String name,  String mobile,  String address,  String note,  String status,  String payRef,  String postalCode,  bool hasReceipt,  bool seen,  String instagram,  int rating,  String comment,  DateTime createdAt,  List<ItemEntity> items)?  $default,) {final _that = this;
switch (_that) {
case _OrderEntity() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.mobile,_that.address,_that.note,_that.status,_that.payRef,_that.postalCode,_that.hasReceipt,_that.seen,_that.instagram,_that.rating,_that.comment,_that.createdAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderEntity extends OrderEntity {
  const _OrderEntity({required this.id, required this.code, required this.name, required this.mobile, required this.address, this.note = '', required this.status, this.payRef = '', this.postalCode = '', this.hasReceipt = false, this.seen = true, this.instagram = '', this.rating = 0, this.comment = '', required this.createdAt, required  List<ItemEntity> items}): _items = items,super._();
  factory _OrderEntity.fromJson(Map<String, dynamic> json) => _$OrderEntityFromJson(json);

@override final  int id;
@override final  String code;
@override final  String name;
@override final  String mobile;
@override final  String address;
@override@JsonKey() final  String note;
@override final  String status;
@override@JsonKey() final  String payRef;
@override@JsonKey() final  String postalCode;
@override@JsonKey() final  bool hasReceipt;
@override@JsonKey() final  bool seen;
@override@JsonKey() final  String instagram;
@override@JsonKey() final  int rating;
@override@JsonKey() final  String comment;
@override final  DateTime createdAt;
 final  List<ItemEntity> _items;
@override List<ItemEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of OrderEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderEntityCopyWith<_OrderEntity> get copyWith => __$OrderEntityCopyWithImpl<_OrderEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.address, address) || other.address == address)&&(identical(other.note, note) || other.note == note)&&(identical(other.status, status) || other.status == status)&&(identical(other.payRef, payRef) || other.payRef == payRef)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.hasReceipt, hasReceipt) || other.hasReceipt == hasReceipt)&&(identical(other.seen, seen) || other.seen == seen)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,name,mobile,address,note,status,payRef,postalCode,hasReceipt,seen,instagram,rating,comment,createdAt,const DeepCollectionEquality().hash(_items));
}

@override
String toString() {
    return 'OrderEntity(id: $id, code: $code, name: $name, mobile: $mobile, address: $address, note: $note, status: $status, payRef: $payRef, postalCode: $postalCode, hasReceipt: $hasReceipt, seen: $seen, instagram: $instagram, rating: $rating, comment: $comment, createdAt: $createdAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$OrderEntityCopyWith<$Res> implements $OrderEntityCopyWith<$Res> {
  factory _$OrderEntityCopyWith(_OrderEntity value, $Res Function(_OrderEntity) _then) = __$OrderEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String name, String mobile, String address, String note, String status, String payRef, String postalCode, bool hasReceipt, bool seen, String instagram, int rating, String comment, DateTime createdAt, List<ItemEntity> items
});




}
/// @nodoc
class __$OrderEntityCopyWithImpl<$Res>
    implements _$OrderEntityCopyWith<$Res> {
  __$OrderEntityCopyWithImpl(this._self, this._then);

  final _OrderEntity _self;
  final $Res Function(_OrderEntity) _then;

/// Create a copy of OrderEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? mobile = null,Object? address = null,Object? note = null,Object? status = null,Object? payRef = null,Object? postalCode = null,Object? hasReceipt = null,Object? seen = null,Object? instagram = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? items = null,}) {
  return _then(_OrderEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,payRef: null == payRef ? _self.payRef : payRef // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,hasReceipt: null == hasReceipt ? _self.hasReceipt : hasReceipt // ignore: cast_nullable_to_non_nullable
as bool,seen: null == seen ? _self.seen : seen // ignore: cast_nullable_to_non_nullable
as bool,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ItemEntity>,
  ));
}


}

// dart format on
