import 'package:fpdart/fpdart.dart';

typedef ResultData<T> = Either<FailureModel, T>;

sealed class FailureModel {
  final String message;
  const FailureModel({required this.message});

  @override
  String toString() => message;
}

class UnexpectedFailure extends FailureModel {
  const UnexpectedFailure({super.message = 'خطای ناشناخته رخ داده است. لطفا دوباره تلاش کنید.'});
}

class NotFoundFailure extends FailureModel {
  const NotFoundFailure({String? message}) : super(message: message ?? 'موردی یافت نشد.');
}

class LocalDbFailure extends FailureModel {
  const LocalDbFailure({required super.message});
}

class WrongPinFailure extends FailureModel {
  const WrongPinFailure({super.message = 'رمز اشتباه است'});
}

class ValidationFailure extends FailureModel {
  const ValidationFailure({required super.message});
}
