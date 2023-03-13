import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;

  ///Allow to pop screen if LoadingOverlay is currently showing
  final bool allowPop;

  ///Disable pop completely
  final bool disablePop;

  ///Custom child widget, will replace with Scaffold if this value is null
  final Widget? child;
  const SkadiScaffold({
    super.key,
    this.appBar,
    this.allowPop = false,
    this.disablePop = false,
    this.body,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final widget = LoadingOverlayPopScope(
      allowPop: allowPop,
      child: KeyboardDismiss(
        child: child ??
            Scaffold(
              appBar: appBar,
              body: body,
            ),
      ),
    );
    if (disablePop) {
      return WillPopDisable(child: widget);
    }
    return widget;
  }
}
