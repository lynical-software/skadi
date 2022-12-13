import 'package:flutter/material.dart';

class KeyboardDismiss extends StatelessWidget {
  final Widget child;
  final VoidCallback? onDismiss;
  const KeyboardDismiss({
    Key? key,
    required this.child,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onDismiss?.call();
      },
      child: child,
    );
  }
}
