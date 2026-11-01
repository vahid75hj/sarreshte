import '../../failure_model.dart';
import '../../repository/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  ResultData<void> call(String pin) => _repository.login(pin);
}
