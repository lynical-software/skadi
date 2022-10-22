import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension SkadiListenableExtension on Listenable {
  Widget builder({required TransitionBuilder builder, Widget? child}) {
    return AnimatedBuilder(
      animation: this,
      builder: builder,
      child: child,
    );
  }
}

extension SkadiValueListenableExtension<T> on ValueListenable<T> {
  ///ValueListenable listener widget that only expose value
  Widget listen(Widget Function(T) builder) {
    return AnimatedBuilder(
      animation: this,
      builder: (context, child) {
        return builder(value);
      },
    );
  }

  ///ValueListenable listener widget that support [child]
  Widget listenChild(
      {required Widget Function(T, Widget?) builder, Widget? child}) {
    return AnimatedBuilder(
      animation: this,
      child: child,
      builder: (context, child) {
        return builder(value, child);
      },
    );
  }
}
