import 'package:flutter/material.dart';

///An InputBorder for TextField
class ShadowInputBorder extends InputBorder {
  ///border radius of the border
  final BorderRadius borderRadius;

  ///shadow level of the border
  final double elevation;

  ///Color of the shadow
  final Color shadowColor;

  ///Color that fill the entire TextField
  final Color fillColor;

  /// Creates an shadow border for an [InputDecorator]
  ///
  ///the [fillColor] parameter is required to cover the shadow beneath the TextField
  ///so [fillColor] value from original TextField will be ignore
  ///
  /// The [borderRadius] parameter defaults to a value where the top left
  /// and right corners have a circular radius of 8.0. The [borderRadius]
  /// parameter must not be null.
  const ShadowInputBorder({
    required this.elevation,
    required this.fillColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.shadowColor = Colors.black87,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(2);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  bool get isOutline => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = Paint()..color = fillColor;
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawShadow(getOuterPath(rect), shadowColor, elevation, false);
    canvas.drawRRect(outer, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return ShadowInputBorder(elevation: elevation, fillColor: fillColor);
  }

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return ShadowInputBorder(elevation: elevation, fillColor: fillColor);
  }
}
