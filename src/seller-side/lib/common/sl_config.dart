import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_provider/deep_link/deep_link_impl.dart';
import '../data/data_provider/deep_link/deep_link_interface.dart';
import '../data/data_provider/launcher/launcher_impl.dart';
import '../data/data_provider/launcher/launcher_interface.dart';
import '../data/data_provider/order/order_interface.dart';
import '../data/data_provider/order/order_local_impl.dart';
import '../data/data_provider/product/product_interface.dart';
import '../data/data_provider/product/product_local_impl.dart';
import '../data/data_provider/reminder/reminder_interface.dart';
import '../data/data_provider/reminder/reminder_local_impl.dart';
import '../data/data_provider/storage/storage_interface.dart';
import '../data/data_provider/storage/storage_local_impl.dart';
import '../domain/repository/auth/auth_repository.dart';
import '../domain/repository/customer/customer_repository.dart';
import '../domain/repository/order/order_repository.dart';
import '../domain/repository/product/product_repository.dart';
import '../domain/repository/reminder/reminder_repository.dart';
import '../domain/use_case/auth/login.dart';
import '../domain/use_case/contact/contact_customer.dart';
import '../domain/use_case/customer/get_customer_detail.dart';
import '../domain/use_case/customer/list_customers.dart';
import '../domain/use_case/customer/list_reorder_due.dart';
import '../domain/use_case/message/compose_messages.dart';
import '../domain/use_case/order/add_order.dart';
import '../domain/use_case/order/filter_orders.dart';
import '../domain/use_case/order/find_order_by_code.dart';
import '../domain/use_case/order/get_orders.dart';
import '../domain/use_case/order/parse_dm_order.dart';
import '../domain/use_case/order/reset_demo_data.dart';
import '../domain/use_case/order/update_order.dart';
import '../domain/use_case/product/list_products.dart';
import '../domain/use_case/product/save_products.dart';
import '../domain/use_case/reminder/get_sent_reminders.dart';
import '../domain/use_case/reminder/mark_reminder_sent.dart';
import '../routes/pending_order_link.dart';

/// Service locator: data providers -> repositories -> use cases (same layering as mpm's sl_config).
/// The demo store is loaded here, before runApp, so the first frame already has data.
Future<void> slConfig(GetIt getIt) async {
  // ---- data providers
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  final storage = StorageLocalDataProviderImpl(prefs: prefs);
  await storage.init();
  getIt.registerSingleton<StorageDataProvider>(storage);
  getIt.registerLazySingleton<OrderDataProvider>(() => OrderLocalDataProviderImpl(storage: getIt()));
  getIt.registerLazySingleton<ProductDataProvider>(() => ProductLocalDataProviderImpl(storage: getIt()));
  getIt.registerLazySingleton<ReminderDataProvider>(() => ReminderLocalDataProviderImpl(storage: getIt()));
  getIt.registerLazySingleton<LauncherDataProvider>(() => LauncherDataProviderImpl());
  getIt.registerLazySingleton<DeepLinkDataProvider>(() => DeepLinkDataProviderImpl());

  // ---- repositories
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepository(dataProvider: getIt()));
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepository(dataProvider: getIt()));
  getIt.registerLazySingleton<ReminderRepository>(() => ReminderRepository(dataProvider: getIt()));
  getIt.registerLazySingleton<CustomerRepository>(() => CustomerRepository(orderDataProvider: getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => const AuthRepository());

  // ---- use cases
  getIt.registerLazySingleton(() => GetOrdersUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => FindOrderByCodeUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateOrderUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => AddOrderUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ResetDemoDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ParseDmOrderUseCase(productRepository: getIt()));
  getIt.registerLazySingleton(() => FilterOrdersUseCase());
  getIt.registerLazySingleton(() => ListCustomersUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetCustomerDetailUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ListReorderDueUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetSentRemindersUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => MarkReminderSentUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ListProductsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => SaveProductsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => OpenInstagramUseCase(launcher: getIt()));
  getIt.registerLazySingleton(() => CallCustomerUseCase(launcher: getIt()));
  getIt.registerLazySingleton(() => ComposeDeliveryMessageUseCase());
  getIt.registerLazySingleton(() => ComposePayReminderUseCase());
  getIt.registerLazySingleton(() => ComposeReorderReminderUseCase());
  getIt.registerLazySingleton(() => ComposeTrackLinkMessageUseCase());

  // ---- app services
  getIt.registerLazySingleton(() => PendingOrderLink(deepLinks: getIt(), findOrder: getIt()));
}
