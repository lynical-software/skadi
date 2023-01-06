import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiScaffold extends StatelessWidget {
  final AppBar? appbar;
  final Widget? body;
  final bool allowPop;
  final Scaffold? scaffold;
  const SkadiScaffold({
    super.key,
    this.appbar,
    this.allowPop = false,
    this.body,
    this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPopScope(
      allowPop: allowPop,
      child: KeyboardDismiss(
        child: scaffold ??
            Scaffold(
              appBar: appbar,
              body: body,
            ),
      ),
    );
  }
}
