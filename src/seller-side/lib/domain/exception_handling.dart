import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../data/network/custom_exception.dart';
import 'failure_model.dart';

extension ExtensionOnFuture<T> on Future<T> {
  Future<ResultData<T>> mapToEither() async {
    try {
      return right(await this);
    } catch (ex, trace) {
      return left(_toFailure(ex, trace));
    }
  }
}

/// Synchronous variant for reads from the in-memory demo cache.
ResultData<T> resultOf<T>(T Function() run) {
  try {
    return right(run());
  } catch (ex, trace) {
    return left(_toFailure(ex, trace));
  }
}

FailureModel _toFailure(Object ex, StackTrace trace) {
  if (kDebugMode) debugPrint('$ex\n$trace');
  return switch (ex) {
    NotFoundException(:final errorMessage) => NotFoundFailure(message: errorMessage),
    LocalDbException(:final errorMessage) => LocalDbFailure(message: errorMessage),
    _ => const UnexpectedFailure(),
  };
}
