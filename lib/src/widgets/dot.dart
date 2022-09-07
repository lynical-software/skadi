import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final double size;
  final Color? color;
  final BoxShape shape;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const Dot({
    Key? key,
    this.size = 8,
    this.shape = BoxShape.circle,
    this.color,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
