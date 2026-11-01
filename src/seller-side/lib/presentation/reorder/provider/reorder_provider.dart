import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/customer/customer_stat_entity.dart';
import '../../../domain/failure_model.dart';
import '../../../domain/use_case/customer/list_reorder_due.dart';
import '../../../domain/use_case/reminder/get_sent_reminders.dart';
import '../../../domain/use_case/reminder/mark_reminder_sent.dart';
import '../../orders/provider/orders_provider.dart';

part 'reorder_provider.g.dart';

@riverpod
ResultData<List<CustomerStatEntity>> reorderDue(Ref ref) {
  ref.watch(ordersProvider);
  return GetIt.I<ListReorderDueUseCase>()();
}

/// Mobiles marked «ارسال کردم».
@Riverpod(keepAlive: true)
class SentReminders extends _$SentReminders {
  @override
  ResultData<Set<String>> build() {
    ref.watch(ordersProvider); // a demo reset clears them too
    return GetIt.I<GetSentRemindersUseCase>()();
  }

  Future<void> mark(String mobile, bool sent) async {
    await GetIt.I<MarkReminderSentUseCase>()(mobile, sent);
    ref.invalidateSelf();
  }
}
