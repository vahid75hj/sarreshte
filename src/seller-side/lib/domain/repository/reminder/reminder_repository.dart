import '../../../data/data_provider/reminder/reminder_interface.dart';
import '../../exception_handling.dart';
import '../../failure_model.dart';

class ReminderRepository {
  final ReminderDataProvider _dataProvider;
  const ReminderRepository({required ReminderDataProvider dataProvider}) : _dataProvider = dataProvider;

  ResultData<Set<String>> getSent() => resultOf(_dataProvider.getSent);

  Future<ResultData<void>> setSent(String mobile, bool sent) => _dataProvider.setSent(mobile, sent).mapToEither();
}
