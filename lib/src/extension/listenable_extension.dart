import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

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
  Widget listen(Widget Function(T value) builder) {
    return AnimatedBuilder(
      animation: this,
      builder: (context, child) {
        return builder(value);
      },
    );
  }

  ///ValueListenable listener widget that support [child]
  Widget listenChild({
    required Widget Function(T, Widget?) builder,
    Widget? child,
  }) {
    return AnimatedBuilder(
      animation: this,
      child: child,
      builder: (context, child) {
        return builder(value, child);
      },
    );
  }
}

extension SkadiBoolValueListenableExtension<bool> on ValueListenable<bool> {
  ///ValueListenable listener widget that only build if value is true
  Widget buildWhenTrue(Widget Function() builder, {Widget? onFalse}) {
    return ValueListenableBuilder<bool>(
      valueListenable: this,
      builder: (context, value, child) {
        if (value == true) return builder();
        return onFalse ?? emptySizedBox;
      },
    );
  }
}

extension SkadiTextEditingControllerExtension on TextEditingController {
  String getTrimText() {
    return text.trim();
  }
}

extension SkadiPageControllerExtension on PageController {
  Future<void> simpleAnimateToPage(
    int page, {
    Duration? duration,
    Curve? curve,
  }) async {
    await animateToPage(
      page,
      duration: duration ?? const Duration(milliseconds: 200),
      curve: curve ?? Curves.linear,
    );
  }
}
