import '../storage/storage_interface.dart';
import 'reminder_interface.dart';

class ReminderLocalDataProviderImpl implements ReminderDataProvider {
  final StorageDataProvider _storage;
  ReminderLocalDataProviderImpl({required StorageDataProvider storage}) : _storage = storage;

  @override
  Set<String> getSent() => _storage.read().sent.toSet();

  @override
  Future<void> setSent(String mobile, bool sent) {
    final s = getSent();
    sent ? s.add(mobile) : s.remove(mobile);
    return _storage.write(_storage.read().copyWith(sent: s.toList()));
  }
}
