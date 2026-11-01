/// Exceptions thrown by data providers; mapped to [FailureModel]s in domain/exception_handling.dart.
/// (No network in the demo; the folder name mirrors mpm.)
class NotFoundException implements Exception {
  final String errorMessage;
  NotFoundException({required this.errorMessage});
  @override
  String toString() => errorMessage;
}

class LocalDbException implements Exception {
  final String errorMessage;
  LocalDbException({required this.errorMessage});
  @override
  String toString() => errorMessage;
}
