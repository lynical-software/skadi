import 'dart:async';

catchNothing(FutureOr Function() fn) async {
  try {
    return await fn();
  } catch (e) {
    //Do nothing
  }
}
