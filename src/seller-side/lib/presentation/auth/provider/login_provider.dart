import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/use_case/auth/login.dart';

part 'login_provider.g.dart';

/// Error text under the PIN field ('' = none).
@riverpod
class Login extends _$Login {
  @override
  String build() => '';

  /// true when the PIN is right.
  bool submit(String pin) => GetIt.I<LoginUseCase>()(pin).match((f) {
    state = f.message;
    return false;
  }, (_) => true);
}
