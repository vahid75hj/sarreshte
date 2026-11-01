import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/utils/number_utils.dart';
import '../../../data/entities/order/order_entity.dart';
import '../../../domain/use_case/order/parse_dm_order.dart';
import '../../orders/provider/orders_provider.dart';

part 'dm_draft_provider.g.dart';

/// Draft order extracted from a pasted DM (null until «استخراج سفارش»).
@riverpod
class DmDraft extends _$DmDraft {
  @override
  OrderEntity? build() => null;

  OrderEntity? extract(String text) => state = GetIt.I<ParseDmOrderUseCase>()(text).toNullable();

  Future<void> submit({required String name, required String mobile, required String address}) async {
    final d = state;
    if (d == null) return;
    await ref.read(ordersProvider.notifier).add(d.copyWith(name: name.trim(), mobile: toEn(mobile).trim(), address: address.trim()));
  }
}
