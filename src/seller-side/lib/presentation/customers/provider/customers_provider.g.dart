// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(customers)
final customersProvider = CustomersProvider._();

final class CustomersProvider
    extends
        $FunctionalProvider<
          ResultData<List<CustomerStatEntity>>,
          ResultData<List<CustomerStatEntity>>,
          ResultData<List<CustomerStatEntity>>
        >
    with $Provider<ResultData<List<CustomerStatEntity>>> {
  CustomersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersHash();

  @$internal
  @override
  $ProviderElement<ResultData<List<CustomerStatEntity>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResultData<List<CustomerStatEntity>> create(Ref ref) {
    return customers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultData<List<CustomerStatEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<ResultData<List<CustomerStatEntity>>>(value),
    );
  }
}

String _$customersHash() => r'9d8b8880cc44664c4ba9237f0c9823b4bfa52f20';

@ProviderFor(customerDetail)
final customerDetailProvider = CustomerDetailFamily._();

final class CustomerDetailProvider
    extends
        $FunctionalProvider<
          ResultData<CustomerDetailEntity>,
          ResultData<CustomerDetailEntity>,
          ResultData<CustomerDetailEntity>
        >
    with $Provider<ResultData<CustomerDetailEntity>> {
  CustomerDetailProvider._({
    required CustomerDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerDetailHash();

  @override
  String toString() {
    return r'customerDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<ResultData<CustomerDetailEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResultData<CustomerDetailEntity> create(Ref ref) {
    final argument = this.argument as String;
    return customerDetail(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultData<CustomerDetailEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultData<CustomerDetailEntity>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerDetailHash() => r'5b92fe7ba5dea138298d6d37e6cf15c038e88e49';

final class CustomerDetailFamily extends $Family
    with $FunctionalFamilyOverride<ResultData<CustomerDetailEntity>, String> {
  CustomerDetailFamily._()
    : super(
        retry: null,
        name: r'customerDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CustomerDetailProvider call(String mobile) =>
      CustomerDetailProvider._(argument: mobile, from: this);

  @override
  String toString() => r'customerDetailProvider';
}
