import '../../entities/product/product_entity.dart';

abstract class ProductDataProvider {
  List<ProductEntity> getProducts();
  Future<void> saveProducts(List<ProductEntity> products);
}
