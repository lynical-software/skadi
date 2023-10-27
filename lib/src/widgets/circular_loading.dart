import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  final bool center;
  final bool _adaptive;
  final double? size;
  final Color? color;

  const CircularLoading({
    super.key,
    this.center = false,
    this.size,
    this.color,
  }) : _adaptive = false;

  const CircularLoading.adaptive({
    super.key,
    this.center = false,
    this.size,
    this.color,
  }) : _adaptive = true;

  const CircularLoading.center({
    super.key,
    this.center = true,
    this.size = 24,
    this.color,
  }) : _adaptive = false;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (_adaptive) {
      child = CircularProgressIndicator.adaptive(
        valueColor:
            color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
      );
    } else {
      child = CircularProgressIndicator(
        valueColor:
            color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
      );
    }
    if (size != null) {
      child = SizedBox(
        width: size,
        height: size,
        child: child,
      );
    }
    if (center) {
      child = Center(child: child);
    }
    return child;
  }
}
