import '../../../data/data_provider/product/product_interface.dart';
import '../../../data/entities/product/product_entity.dart';
import '../../exception_handling.dart';
import '../../failure_model.dart';

class ProductRepository {
  final ProductDataProvider _dataProvider;
  const ProductRepository({required ProductDataProvider dataProvider}) : _dataProvider = dataProvider;

  ResultData<List<ProductEntity>> getProducts() => resultOf(_dataProvider.getProducts);

  Future<ResultData<void>> saveProducts(List<ProductEntity> products) => _dataProvider.saveProducts(products).mapToEither();
}
