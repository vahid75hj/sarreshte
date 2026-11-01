part of 'order_repository.dart';

/// Changes the seller can make to one order from the order page.
class UpdateOrderParams extends Equatable {
  final String code;
  final String? status;
  final String? postalCode;
  final bool? seen;
  const UpdateOrderParams({required this.code, this.status, this.postalCode, this.seen});

  @override
  List<Object?> get props => [code, status, postalCode, seen];
}
