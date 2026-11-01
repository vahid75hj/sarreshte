import 'package:freezed_annotation/freezed_annotation.dart';

import '../order/order_entity.dart';
import '../product/product_entity.dart';

part 'demo_snapshot_entity.freezed.dart';
part 'demo_snapshot_entity.g.dart';

/// Whole demo store as saved under the `demo5` key: {products, orders, sent}.
@freezed
abstract class DemoSnapshotEntity with _$DemoSnapshotEntity {
  const factory DemoSnapshotEntity({
    required List<ProductEntity> products,
    required List<OrderEntity> orders,
    /// Mobiles whose reorder reminder was marked «ارسال کردم».
    @Default(<String>[]) List<String> sent,
  }) = _DemoSnapshotEntity;

  factory DemoSnapshotEntity.fromJson(Map<String, dynamic> json) => _$DemoSnapshotEntityFromJson(json);
}
