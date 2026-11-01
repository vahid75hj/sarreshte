// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) => _OrderEntity(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  name: json['name'] as String,
  mobile: json['mobile'] as String,
  address: json['address'] as String,
  note: json['note'] as String? ?? '',
  status: json['status'] as String,
  payRef: json['payRef'] as String? ?? '',
  postalCode: json['postalCode'] as String? ?? '',
  hasReceipt: json['hasReceipt'] as bool? ?? false,
  seen: json['seen'] as bool? ?? true,
  instagram: json['instagram'] as String? ?? '',
  rating: (json['rating'] as num?)?.toInt() ?? 0,
  comment: json['comment'] as String? ?? '',
  createdAt: DateTime.parse(json['createdAt'] as String),
  items: (json['items'] as List<dynamic>)
      .map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderEntityToJson(_OrderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'mobile': instance.mobile,
      'address': instance.address,
      'note': instance.note,
      'status': instance.status,
      'payRef': instance.payRef,
      'postalCode': instance.postalCode,
      'hasReceipt': instance.hasReceipt,
      'seen': instance.seen,
      'instagram': instance.instagram,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
