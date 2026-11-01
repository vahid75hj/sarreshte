abstract class ReminderDataProvider {
  /// Mobiles whose reorder reminder was marked as sent.
  Set<String> getSent();
  Future<void> setSent(String mobile, bool sent);
}
