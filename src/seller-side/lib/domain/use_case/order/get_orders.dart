import '../../../data/entities/order/order_entity.dart';
import '../../failure_model.dart';
import '../../repository/order/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository _repository;
  GetOrdersUseCase({required OrderRepository repository}) : _repository = repository;

  ResultData<List<OrderEntity>> call() => _repository.getOrders();
}
