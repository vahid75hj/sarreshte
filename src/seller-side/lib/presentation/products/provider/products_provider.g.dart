// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Products)
final productsProvider = ProductsProvider._();

final class ProductsProvider
    extends $NotifierProvider<Products, ResultData<List<ProductEntity>>> {
  ProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsHash();

  @$internal
  @override
  Products create() => Products();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultData<List<ProductEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultData<List<ProductEntity>>>(
        value,
      ),
    );
  }
}

String _$productsHash() => r'6a639dd12c105b8bb2b8341688e75eab1201fd70';

abstract class _$Products extends $Notifier<ResultData<List<ProductEntity>>> {
  ResultData<List<ProductEntity>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ResultData<List<ProductEntity>>,
              ResultData<List<ProductEntity>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ResultData<List<ProductEntity>>,
                ResultData<List<ProductEntity>>
              >,
              ResultData<List<ProductEntity>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
