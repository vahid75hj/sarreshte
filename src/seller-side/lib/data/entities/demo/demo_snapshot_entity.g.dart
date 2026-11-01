// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_snapshot_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DemoSnapshotEntity _$DemoSnapshotEntityFromJson(Map<String, dynamic> json) =>
    _DemoSnapshotEntity(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      orders: (json['orders'] as List<dynamic>)
          .map((e) => OrderEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      sent:
          (json['sent'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$DemoSnapshotEntityToJson(_DemoSnapshotEntity instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
      'orders': instance.orders.map((e) => e.toJson()).toList(),
      'sent': instance.sent,
    };
