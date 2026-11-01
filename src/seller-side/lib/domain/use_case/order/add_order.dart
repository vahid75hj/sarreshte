import '../../../data/entities/order/order_entity.dart';
import '../../failure_model.dart';
import '../../repository/order/order_repository.dart';

class AddOrderUseCase {
  final OrderRepository _repository;
  AddOrderUseCase({required OrderRepository repository}) : _repository = repository;

  Future<ResultData<OrderEntity>> call(OrderEntity draft) => _repository.addOrder(draft);
}
