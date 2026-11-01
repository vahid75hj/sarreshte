// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_stat_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerStatEntity {

 String get name; String get mobile; String get address; String get instagram; int get count; int get spent; DateTime get last; List<ItemEntity> get lastItems;
/// Create a copy of CustomerStatEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStatEntityCopyWith<CustomerStatEntity> get copyWith => _$CustomerStatEntityCopyWithImpl<CustomerStatEntity>(this as CustomerStatEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CustomerStatEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerStatEntity&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.mobile, _this.mobile) || other.mobile == _this.mobile)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.instagram, _this.instagram) || other.instagram == _this.instagram)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.spent, _this.spent) || other.spent == _this.spent)&&(identical(other.last, _this.last) || other.last == _this.last)&&const DeepCollectionEquality().equals(other.lastItems, _this.lastItems));
}


@override
int get hashCode {
  final _this = this as CustomerStatEntity;
  return Object.hash(runtimeType,_this.name,_this.mobile,_this.address,_this.instagram,_this.count,_this.spent,_this.last,const DeepCollectionEquality().hash(_this.lastItems));
}

@override
String toString() {
  final _this = this as CustomerStatEntity;
  return 'CustomerStatEntity(name: ${_this.name}, mobile: ${_this.mobile}, address: ${_this.address}, instagram: ${_this.instagram}, count: ${_this.count}, spent: ${_this.spent}, last: ${_this.last}, lastItems: ${_this.lastItems})';
}


}

/// @nodoc
abstract mixin class $CustomerStatEntityCopyWith<$Res>  {
  factory $CustomerStatEntityCopyWith(CustomerStatEntity value, $Res Function(CustomerStatEntity) _then) = _$CustomerStatEntityCopyWithImpl;
@useResult
$Res call({
 String name, String mobile, String address, String instagram, int count, int spent, DateTime last, List<ItemEntity> lastItems
});




}
/// @nodoc
class _$CustomerStatEntityCopyWithImpl<$Res>
    implements $CustomerStatEntityCopyWith<$Res> {
  _$CustomerStatEntityCopyWithImpl(this._self, this._then);

  final CustomerStatEntity _self;
  final $Res Function(CustomerStatEntity) _then;

/// Create a copy of CustomerStatEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? mobile = null,Object? address = null,Object? instagram = null,Object? count = null,Object? spent = null,Object? last = null,Object? lastItems = null,}) {
  return _then(CustomerStatEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as int,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as DateTime,lastItems: null == lastItems ? _self.lastItems : lastItems // ignore: cast_nullable_to_non_nullable
as List<ItemEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerStatEntity].
extension CustomerStatEntityPatterns on CustomerStatEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerStatEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerStatEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerStatEntity value)  $default,){
final _that = this;
switch (_that) {
case _CustomerStatEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerStatEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerStatEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String mobile,  String address,  String instagram,  int count,  int spent,  DateTime last,  List<ItemEntity> lastItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerStatEntity() when $default != null:
return $default(_that.name,_that.mobile,_that.address,_that.instagram,_that.count,_that.spent,_that.last,_that.lastItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String mobile,  String address,  String instagram,  int count,  int spent,  DateTime last,  List<ItemEntity> lastItems)  $default,) {final _that = this;
switch (_that) {
case _CustomerStatEntity():
return $default(_that.name,_that.mobile,_that.address,_that.instagram,_that.count,_that.spent,_that.last,_that.lastItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String mobile,  String address,  String instagram,  int count,  int spent,  DateTime last,  List<ItemEntity> lastItems)?  $default,) {final _that = this;
switch (_that) {
case _CustomerStatEntity() when $default != null:
return $default(_that.name,_that.mobile,_that.address,_that.instagram,_that.count,_that.spent,_that.last,_that.lastItems);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerStatEntity extends CustomerStatEntity {
  const _CustomerStatEntity({required this.name, required this.mobile, required this.address, required this.instagram, required this.count, required this.spent, required this.last, required  List<ItemEntity> lastItems}): _lastItems = lastItems,super._();
  

@override final  String name;
@override final  String mobile;
@override final  String address;
@override final  String instagram;
@override final  int count;
@override final  int spent;
@override final  DateTime last;
 final  List<ItemEntity> _lastItems;
@override List<ItemEntity> get lastItems {
  if (_lastItems is EqualUnmodifiableListView) return _lastItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lastItems);
}


/// Create a copy of CustomerStatEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStatEntityCopyWith<_CustomerStatEntity> get copyWith => __$CustomerStatEntityCopyWithImpl<_CustomerStatEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerStatEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.address, address) || other.address == address)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.count, count) || other.count == count)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.last, last) || other.last == last)&&const DeepCollectionEquality().equals(other.lastItems, _lastItems));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,mobile,address,instagram,count,spent,last,const DeepCollectionEquality().hash(_lastItems));
}

@override
String toString() {
    return 'CustomerStatEntity(name: $name, mobile: $mobile, address: $address, instagram: $instagram, count: $count, spent: $spent, last: $last, lastItems: $lastItems)';
}


}

/// @nodoc
abstract mixin class _$CustomerStatEntityCopyWith<$Res> implements $CustomerStatEntityCopyWith<$Res> {
  factory _$CustomerStatEntityCopyWith(_CustomerStatEntity value, $Res Function(_CustomerStatEntity) _then) = __$CustomerStatEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String mobile, String address, String instagram, int count, int spent, DateTime last, List<ItemEntity> lastItems
});




}
/// @nodoc
class __$CustomerStatEntityCopyWithImpl<$Res>
    implements _$CustomerStatEntityCopyWith<$Res> {
  __$CustomerStatEntityCopyWithImpl(this._self, this._then);

  final _CustomerStatEntity _self;
  final $Res Function(_CustomerStatEntity) _then;

/// Create a copy of CustomerStatEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? mobile = null,Object? address = null,Object? instagram = null,Object? count = null,Object? spent = null,Object? last = null,Object? lastItems = null,}) {
  return _then(_CustomerStatEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mobile: null == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,instagram: null == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as int,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as DateTime,lastItems: null == lastItems ? _self._lastItems : lastItems // ignore: cast_nullable_to_non_nullable
as List<ItemEntity>,
  ));
}


}

// dart format on
