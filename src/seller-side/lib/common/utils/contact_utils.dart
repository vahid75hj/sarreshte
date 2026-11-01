import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../domain/use_case/contact/contact_customer.dart';
import '../extention/context.dart';

/// UI helper: open a customer's Instagram DM, or tell the seller there is no id.
Future<void> openIg(BuildContext ctx, String handle, {bool dm = true}) async {
  final ok = await GetIt.I<OpenInstagramUseCase>()(handle, dm: dm);
  if (!ok && ctx.mounted) ctx.snack('آیدی اینستاگرام ثبت نشده');
}
