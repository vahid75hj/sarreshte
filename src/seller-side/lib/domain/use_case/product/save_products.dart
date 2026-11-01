import '../../../data/entities/product/product_entity.dart';
import '../../failure_model.dart';
import '../../repository/product/product_repository.dart';

/// Persists the whole product list (add / edit / toggle / delete are list edits in the provider).
class SaveProductsUseCase {
  final ProductRepository _repository;
  SaveProductsUseCase({required ProductRepository repository}) : _repository = repository;

  Future<ResultData<void>> call(List<ProductEntity> products) => _repository.saveProducts(products);
}
