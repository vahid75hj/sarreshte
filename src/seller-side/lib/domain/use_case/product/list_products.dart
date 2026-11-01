import '../../../data/entities/product/product_entity.dart';
import '../../failure_model.dart';
import '../../repository/product/product_repository.dart';

class ListProductsUseCase {
  final ProductRepository _repository;
  ListProductsUseCase({required ProductRepository repository}) : _repository = repository;

  ResultData<List<ProductEntity>> call() => _repository.getProducts();
}
