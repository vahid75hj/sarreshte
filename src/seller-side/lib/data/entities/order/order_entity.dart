import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/app_constants.dart';
import '../../../common/utils/number_utils.dart';
import 'item_entity.dart';
import 'order_status.dart';

part 'order_entity.freezed.dart';
part 'order_entity.g.dart';

@freezed
abstract class OrderEntity with _$OrderEntity {
  const OrderEntity._();

  const factory OrderEntity({
    required int id,
    required String code,
    required String name,
    required String mobile,
    required String address,
    @Default('') String note,
    required String status,
    @Default('') String payRef,
    @Default('') String postalCode,
    @Default(false) bool hasReceipt,
    @Default(true) bool seen,
    @Default('') String instagram,
    @Default(0) int rating,
    @Default('') String comment,
    required DateTime createdAt,
    required List<ItemEntity> items,
  }) = _OrderEntity;

  factory OrderEntity.fromJson(Map<String, dynamic> json) => _$OrderEntityFromJson(json);

  bool get cancelled => status == OrderStatus.cancelled || status == OrderStatus.cancelledByCustomer;
  bool get archived => status == OrderStatus.delivered || cancelled;
  bool get unseen => status == OrderStatus.delivered && !seen;
  bool get followUp => status == OrderStatus.shipped && DateTime.now().difference(createdAt).inDays >= AppConstants.deliveryFollowUpDays;
  bool get shipLate => status == OrderStatus.paid && DateTime.now().difference(createdAt).inDays >= AppConstants.shipLateDays;
  bool get payReminder => status == OrderStatus.pendingPayment && DateTime.now().difference(createdAt).inHours >= 24;
  bool get privateReview => rating > 0 && rating <= 3;
  int get total => items.fold(0, (s, i) => s + i.price * i.qty);

  /// Search by code, name, mobile or Instagram id (Persian digits and @ are accepted).
  bool matches(String q) {
    final t = toEn(q).trim().toLowerCase().replaceAll('@', '');
    if (t.isEmpty) return true;
    return code.toLowerCase().contains(t) || name.contains(q.trim()) || mobile.contains(t) || instagram.toLowerCase().contains(t);
  }
}
