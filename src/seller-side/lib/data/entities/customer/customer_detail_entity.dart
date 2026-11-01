import 'package:freezed_annotation/freezed_annotation.dart';

import '../order/order_entity.dart';

part 'customer_detail_entity.freezed.dart';

/// Everything the customer page shows, computed in the domain layer.
@freezed
abstract class CustomerDetailEntity with _$CustomerDetailEntity {
  const factory CustomerDetailEntity({
    /// All orders of this customer, newest first (including cancelled).
    required List<OrderEntity> orders,
    required int validCount,
    required int spent,
    required String topProduct,
    /// null when the customer has no rated order.
    double? avgRating,
    required int ratedCount,
    required String instagram,
  }) = _CustomerDetailEntity;
}
