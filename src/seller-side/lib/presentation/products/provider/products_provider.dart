import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/riverpod_helper.dart';
import '../../../data/entities/product/product_entity.dart';
import '../../../domain/failure_model.dart';
import '../../../domain/use_case/product/list_products.dart';
import '../../../domain/use_case/product/save_products.dart';
import '../../orders/provider/orders_provider.dart';

part 'products_provider.g.dart';

@Riverpod(keepAlive: true)
class Products extends _$Products {
  @override
  ResultData<List<ProductEntity>> build() {
    ref.watch(ordersProvider); // a demo reset restores products too
    return GetIt.I<ListProductsUseCase>()();
  }

  List<ProductEntity> get _list => state.getOr(const []);

  Future<void> _save(List<ProductEntity> ps) async {
    await GetIt.I<SaveProductsUseCase>()(ps);
    ref.invalidateSelf();
  }

  /// Adds a new product (when [old] is null) or renames / re-prices [old].
  Future<void> upsert(ProductEntity? old, String name, int price) => _save(old == null
      ? [..._list, ProductEntity(id: _list.fold(0, (s, x) => x.id > s ? x.id : s) + 1, name: name, price: price)]
      : [for (final p in _list) p.id == old.id ? p.copyWith(name: name, price: price) : p]);

  Future<void> setActive(ProductEntity p, bool v) => _save([for (final x in _list) x.id == p.id ? x.copyWith(active: v) : x]);

  Future<void> remove(ProductEntity p) => _save(_list.where((x) => x.id != p.id).toList());
}
