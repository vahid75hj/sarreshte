import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../failure_model.dart';
import '../../repository/customer/customer_repository.dart';

/// Customers whose last purchase was 30–60 days ago.
class ListReorderDueUseCase {
  final CustomerRepository _repository;
  ListReorderDueUseCase({required CustomerRepository repository}) : _repository = repository;

  ResultData<List<CustomerStatEntity>> call() =>
      _repository.listCustomers().map((cs) => cs.where((c) => c.daysSince >= 30 && c.daysSince <= 60).toList());
}
