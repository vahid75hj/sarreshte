import 'package:flutter/material.dart';

import '../domain/failure_model.dart';
import 'widget/error.dart';

/// Renders a [ResultData] held in a provider: success -> [successBuilder], failure -> retry widget.
/// Same idea as mpm's RiverPodConnectionHelperWidget, but synchronous: demo data is loaded before runApp,
/// so there is no loading state and the first frame looks exactly like before.
class ResultDataView<T> extends StatelessWidget {
  final ResultData<T> value;
  final Widget Function(T) successBuilder;
  final VoidCallback tryAgain;
  const ResultDataView({super.key, required this.value, required this.successBuilder, required this.tryAgain});

  @override
  Widget build(BuildContext context) => value.match((f) => RetryFailureWidget(error: f, tryAgain: tryAgain), successBuilder);
}

extension ResultDataX<T> on ResultData<T> {
  /// Value or [fallback] (used where a failure is already shown elsewhere on the screen).
  T getOr(T fallback) => getOrElse((_) => fallback);
}
