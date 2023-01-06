import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiScaffold extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;
  final bool allowPop;
  final Scaffold? scaffold;
  const SkadiScaffold({
    super.key,
    this.appBar,
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
              appBar: appBar,
              body: body,
            ),
      ),
    );
  }
}
