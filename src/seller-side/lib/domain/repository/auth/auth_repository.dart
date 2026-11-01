import 'package:fpdart/fpdart.dart';

import '../../../common/utils/app_constants.dart';
import '../../../common/utils/number_utils.dart';
import '../../failure_model.dart';

/// Demo login: a fixed PIN for the fixed demo shop account.
class AuthRepository {
  const AuthRepository();

  ResultData<void> login(String pin) => toEn(pin) == AppConstants.demoPin ? right(null) : left(const WrongPinFailure());
}
