import 'package:flutter/material.dart' show DateTimeRange;
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/riverpod_helper.dart';
import '../../../domain/use_case/order/filter_orders.dart';
import 'orders_provider.dart';

part 'order_board_filter_provider.g.dart';

class OrderBoardFilter {
  /// Index into [openOrderGroups].
  final int group;
  final String query;
  final DateTimeRange? range;
  final String rangeLabel;
  const OrderBoardFilter({required this.group, this.query = '', this.range, this.rangeLabel = ''});

  bool get searching => query.trim().isNotEmpty || range != null;

  OrderBoardFilter copyWith({int? group, String? query, DateTimeRange? range, bool clearRange = false, String? rangeLabel}) => OrderBoardFilter(
    group: group ?? this.group, query: query ?? this.query, range: clearRange ? null : range ?? this.range, rangeLabel: rangeLabel ?? this.rangeLabel);
}

/// Chip / search / date filter of the orders tab. Auto-disposed with the tab, like the old widget state.
@riverpod
class OrderBoardFilterNotifier extends _$OrderBoardFilterNotifier {
  @override
  OrderBoardFilter build() =>
      OrderBoardFilter(group: GetIt.I<FilterOrdersUseCase>().defaultGroup(ref.read(ordersProvider).getOr(const [])));

  void setGroup(int g) => state = state.copyWith(group: g);
  void setQuery(String q) => state = state.copyWith(query: q);
  void setRange(DateTimeRange r, String label) => state = state.copyWith(range: r, rangeLabel: label);
  void clearRange() => state = state.copyWith(clearRange: true);
}
