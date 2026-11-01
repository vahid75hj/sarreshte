import '../../../data/entities/order/order_entity.dart';
import '../../failure_model.dart';
import '../../repository/order/order_repository.dart';

class FindOrderByCodeUseCase {
  final OrderRepository _repository;
  FindOrderByCodeUseCase({required OrderRepository repository}) : _repository = repository;

  ResultData<OrderEntity> call(String code) => _repository.findByCode(code);
}
