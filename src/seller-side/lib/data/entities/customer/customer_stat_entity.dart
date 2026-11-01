import 'package:freezed_annotation/freezed_annotation.dart';

import '../order/item_entity.dart';

part 'customer_stat_entity.freezed.dart';

/// A customer derived from their (non-cancelled) orders, grouped by mobile.
@freezed
abstract class CustomerStatEntity with _$CustomerStatEntity {
  const CustomerStatEntity._();

  const factory CustomerStatEntity({
    required String name,
    required String mobile,
    required String address,
    required String instagram,
    required int count,
    required int spent,
    required DateTime last,
    required List<ItemEntity> lastItems,
  }) = _CustomerStatEntity;

  int get daysSince => DateTime.now().difference(last).inDays;
}
