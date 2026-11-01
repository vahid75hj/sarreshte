import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/customer/customer_detail_entity.dart';
import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../../domain/failure_model.dart';
import '../../../domain/use_case/customer/get_customer_detail.dart';
import '../../../domain/use_case/customer/list_customers.dart';
import '../../orders/provider/orders_provider.dart';

part 'customers_provider.g.dart';

@riverpod
ResultData<List<CustomerStatEntity>> customers(Ref ref) {
  ref.watch(ordersProvider);
  return GetIt.I<ListCustomersUseCase>()();
}

@riverpod
ResultData<CustomerDetailEntity> customerDetail(Ref ref, String mobile) {
  ref.watch(ordersProvider);
  return GetIt.I<GetCustomerDetailUseCase>()(mobile);
}
