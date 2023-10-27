import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skadi/src/widgets/skadi_confirmation_dialog.dart';

catchNothing(FutureOr Function() fn) async {
  try {
    return await fn();
  } catch (e) {
    //Do nothing
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
