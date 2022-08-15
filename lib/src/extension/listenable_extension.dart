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
