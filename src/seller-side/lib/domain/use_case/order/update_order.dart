import '../../../data/entities/order/order_entity.dart';
import '../../failure_model.dart';
import '../../repository/order/order_repository.dart';

/// Status change, postal tracking code, or marking a completed order as seen.
class UpdateOrderUseCase {
  final OrderRepository _repository;
  UpdateOrderUseCase({required OrderRepository repository}) : _repository = repository;

  Future<ResultData<OrderEntity>> call(UpdateOrderParams params) => _repository.updateOrder(params);
}
