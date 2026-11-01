import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../failure_model.dart';
import '../../repository/customer/customer_repository.dart';

class ListCustomersUseCase {
  final CustomerRepository _repository;
  ListCustomersUseCase({required CustomerRepository repository}) : _repository = repository;

  ResultData<List<CustomerStatEntity>> call() => _repository.listCustomers();
}
