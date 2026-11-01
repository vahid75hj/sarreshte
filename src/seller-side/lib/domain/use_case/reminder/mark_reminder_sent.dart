import '../../failure_model.dart';
import '../../repository/reminder/reminder_repository.dart';

class MarkReminderSentUseCase {
  final ReminderRepository _repository;
  MarkReminderSentUseCase({required ReminderRepository repository}) : _repository = repository;

  Future<ResultData<void>> call(String mobile, bool sent) => _repository.setSent(mobile, sent);
}
