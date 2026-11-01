import '../../entities/product/product_entity.dart';
import '../storage/storage_interface.dart';
import 'product_interface.dart';

class ProductLocalDataProviderImpl implements ProductDataProvider {
  final StorageDataProvider _storage;
  ProductLocalDataProviderImpl({required StorageDataProvider storage}) : _storage = storage;

  @override
  List<ProductEntity> getProducts() => _storage.read().products;

  @override
  Future<void> saveProducts(List<ProductEntity> products) => _storage.write(_storage.read().copyWith(products: products));
}
