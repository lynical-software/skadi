import 'package:flutter/material.dart';

import 'dot_tab_indicator.dart';

///An Underline tab indicator but customizable and work best if [isScrollable] is true
class SmallUnderLineTabIndicator extends Decoration {
  ///indicator width
  final double width;

  ///indicator height
  final double height;

  ///indicator border radius
  final double radius;

  ///indicator padding left side
  final double paddingLeft;

  ///indicator color
  final Color color;

  ///[DotAlignment] whether it's bottom or top of tab's label
  final TabAlignment tabAlignment;

  const SmallUnderLineTabIndicator({
    required this.color,
    this.width = 16,
    this.height = 8,
    this.radius = 8,
    this.paddingLeft = 0,
    this.tabAlignment = TabAlignment.bottom,
  });

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
    return _SmallUnderLineTabIndicatorPainter(
      onChanged!,
      color,
      width,
      height,
      radius,
      paddingLeft,
      tabAlignment,
    );
  }
}

class _SmallUnderLineTabIndicatorPainter extends BoxPainter {
  final Color color;
  final double width;
  final double height;
  final double radius;
  final double paddingLeft;
  final TabAlignment tabAlignment;
  _SmallUnderLineTabIndicatorPainter(
    VoidCallback onChanged,
    this.color,
    this.width,
    this.height,
    this.radius,
    this.paddingLeft,
    this.tabAlignment,
  ) : super(onChanged);
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final double yOffset = tabAlignment == TabAlignment.bottom
        ? configuration.size!.height - 8
        : 0;
    final Offset indicatorOffset = offset + Offset(paddingLeft, yOffset);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            indicatorOffset.dx,
            indicatorOffset.dy,
            width.clamp(4.0, configuration.size!.width),
            height,
          ),
          Radius.circular(radius),
        ),
        paint);
  }
}
