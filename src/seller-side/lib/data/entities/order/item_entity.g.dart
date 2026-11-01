// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemEntity _$ItemEntityFromJson(Map<String, dynamic> json) => _ItemEntity(
  name: json['name'] as String,
  price: (json['price'] as num).toInt(),
  qty: (json['qty'] as num).toInt(),
);

Map<String, dynamic> _$ItemEntityToJson(_ItemEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'qty': instance.qty,
    };
