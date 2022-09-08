import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final double size;
  final double? width;
  final double? height;
  final BoxShape shape;
  final Widget? child;

  ///Use Theme's primary color if color isn't provide
  final Color? color;

  final EdgeInsets? margin;

  ///Define a horizontal margin which is the most use case for this widget
  final double? horizontal;

  ///Create a Container with default value that look like a dot
  ///default [size] is `8`, you can set [width] or [height] to ignore [size] value
  ///Has no margin or padding, [horizontal] and [margin] can be use to add margin
  const Dot({
    Key? key,
    this.size = 8,
    this.shape = BoxShape.circle,
    this.color,
    this.margin,
    this.horizontal,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: horizontal != null
          ? EdgeInsets.symmetric(horizontal: horizontal ?? 0.0)
          : margin,
      width: width ?? size,
      height: height ?? size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        shape: shape,
      ),
      child: child,
    );
  }
}
