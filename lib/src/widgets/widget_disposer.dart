import 'package:flutter/material.dart';

class WidgetDisposer extends StatefulWidget {
  final VoidCallback onDispose;
  final Widget child;
  const WidgetDisposer({Key? key, required this.onDispose, required this.child})
      : super(key: key);

  @override
  State<WidgetDisposer> createState() => _WidgetDisposerState();
}

class _WidgetDisposerState extends State<WidgetDisposer> {
  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
