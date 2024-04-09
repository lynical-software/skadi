import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

catchNothing(
  FutureOr Function() fn, {
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    return await fn();
  } catch (exception, stackTrace) {
    //Do nothing
    onError?.call(exception, stackTrace);
  }
}

Future<bool> showConfirmationDialog(
  BuildContext context,
  String message, {
  bool danger = false,
}) async {
  var result = await showAdaptiveDialog(
    context: context,
    builder: (context) {
      if (danger) {
        return SkadiConfirmationDialog.danger(
          content: Text(message),
        );
      }
      return SkadiConfirmationDialog(
        content: Text(message),
      );
    },
  );
  return result ?? false;
}
