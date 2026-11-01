# سررشته – اپ فروشنده (Sarreshte seller app)

اپ فلاتر فروشنده برای مدیریت سفارش‌های اینستاگرامی. نسخه‌ی دمو: داده‌ها نمونه‌اند و فقط روی همان دستگاه (shared_preferences، کلید `demo5`) ذخیره می‌شوند.
Flutter seller app for Instagram home sellers. Demo build: seeded sample data stored locally (shared_preferences, key `demo5`), no server.

- وب / Web: https://vahid75hj.github.io/sarreshte/seller/ (PIN `1234`, deep link `?order=NR1003`)
- اندروید / Android: https://vahid75hj.github.io/sarreshte/downloads/sarreshte.apk

## معماری / Architecture

لایه‌بندی Clean Architecture به سبک پروژه‌ی mobtaker (mpm): لایه‌محور، با جریان یک‌طرفه‌ی وابستگی
`presentation → domain → data`.
Layer-first Clean Architecture, same conventions as the mobtaker (mpm) app; dependencies point inward.

```
lib/
  main.dart                 slConfig(GetIt) → ProviderScope → MyApp
  common/                   shared, feature-agnostic code
    sl_config.dart          get_it registrations: data providers → repositories → use cases
    riverpod_helper.dart    ResultDataView: renders ResultData (success / failure + retry)
    theme/                  AppColors, AppTheme, theme_provider (Riverpod)
    extention/context.dart  snack / copy helpers
    utils/                  app_constants, number_utils (fa, toman), date_utils (Jalali), link_utils, contact_utils
    widget/                 StatusPill, SectionTitle, TagWidget, CountBadge, error
  data/
    entities/<feature>/     freezed + json_serializable models (OrderEntity, ProductEntity, CustomerStatEntity, …)
    data_provider/<feature>/  <x>_interface.dart (abstract XDataProvider) + <x>_local_impl.dart / <x>_impl.dart
                            storage (shared_preferences `demo5`), order, product, reminder, launcher (url_launcher),
                            deep_link (app_links), seed (demo data)
    network/custom_exception.dart   NotFoundException, LocalDbException
  domain/
    failure_model.dart      typedef ResultData<T> = Either<FailureModel, T> (fpdart); sealed FailureModel
    exception_handling.dart Future.mapToEither() / resultOf(): exceptions → FailureModel
    repository/<feature>/   concrete repositories over data providers (order, customer, product, reminder, auth)
    use_case/<feature>/     one class per action, single call() (GetOrders, UpdateOrder, ParseDmOrder, ListReorderDue, Login, …)
  presentation/<feature>/   page/ · provider/ (riverpod_annotation codegen) · widget/
                            auth, home, orders (board, archive, order detail), customers, reorder, products, dm_import
  routes/                   AppRouter (plain Navigator, no auto_route) + PendingOrderLink (web ?order= / Android app links)
test/                       use-case unit tests + demo5 JSON compatibility test
```

| موضوع / Concern | انتخاب / Choice |
|---|---|
| State | Riverpod 3 (`hooks_riverpod`, `@riverpod` codegen), `HookConsumerWidget` |
| DI | `get_it`, manual registration in `common/sl_config.dart` |
| Errors | `fpdart` `Either` → `ResultData<T>`, sealed `FailureModel` with Persian messages |
| Models | `freezed` + `json_serializable` (JSON identical to earlier builds) |
| Routing | `Navigator` via `routes/app_router.dart` (keeps web `?order=` links under `/sarreshte/seller/`) |

فایل‌های تولیدی (`*.g.dart`, `*.freezed.dart`) کامیت شده‌اند؛ برای بیلد و `deploy.sh` نیازی به build_runner نیست.
Generated files are committed, so building / `deploy.sh` needs no build_runner. After changing an entity or provider:

```
dart run build_runner build -d
flutter analyze && flutter test
```
