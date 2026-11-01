import '../../../data/entities/customer/customer_detail_entity.dart';
import '../../failure_model.dart';
import '../../repository/customer/customer_repository.dart';

class GetCustomerDetailUseCase {
  final CustomerRepository _repository;
  GetCustomerDetailUseCase({required CustomerRepository repository}) : _repository = repository;

  ResultData<CustomerDetailEntity> call(String mobile) => _repository.getDetail(mobile);
}
