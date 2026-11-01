import '../../failure_model.dart';
import '../../repository/order/order_repository.dart';

class ResetDemoDataUseCase {
  final OrderRepository _repository;
  ResetDemoDataUseCase({required OrderRepository repository}) : _repository = repository;

  Future<ResultData<void>> call() => _repository.resetDemo();
}
