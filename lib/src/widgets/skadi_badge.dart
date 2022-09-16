import 'package:flutter/material.dart';

import 'spacing.dart';

///A badge that often use in Notification
class SkadiBadge extends StatelessWidget {
  final double radius;
  final String text;
  final TextStyle textStyle;
  final Color color;
  final bool enable;

  ///A badge that often us in fpr notification
  const SkadiBadge({
    Key? key,
    this.radius = 8.0,
    this.text = "",
    this.color = Colors.red,
    this.enable = true,
    this.textStyle = const TextStyle(fontSize: 8, color: Colors.white),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!enable) return emptySizedBox;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
