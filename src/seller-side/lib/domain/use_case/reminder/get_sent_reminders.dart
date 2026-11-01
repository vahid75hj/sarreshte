import '../../failure_model.dart';
import '../../repository/reminder/reminder_repository.dart';

class GetSentRemindersUseCase {
  final ReminderRepository _repository;
  GetSentRemindersUseCase({required ReminderRepository repository}) : _repository = repository;

  ResultData<Set<String>> call() => _repository.getSent();
}
