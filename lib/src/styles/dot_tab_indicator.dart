import 'package:flutter/material.dart';

enum TabBarAlignment { top, bottom }

class DotTabIndicator extends Decoration {
  ///radius for your dot
  final double radius;

  ///dot's color
  final Color color;

  ///Place indicator on Top or Bottom of label
  final TabBarAlignment tabAlignment;

  /// Create a circle and small tab indicator
  const DotTabIndicator({
    required this.color,
    this.radius = 4,
    this.tabAlignment = TabBarAlignment.bottom,
  });
  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
    return _DotTabIndicatorPainter(
      onChanged!,
      radius,
      color,
      tabAlignment,
    );
  }
}

class _DotTabIndicatorPainter extends BoxPainter {
  final double radius;
  final Color color;
  final TabBarAlignment tabAlignment;
  _DotTabIndicatorPainter(
    VoidCallback onChanged,
    this.radius,
    this.color,
    this.tabAlignment,
  ) : super(onChanged);
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final double yOffset = tabAlignment == TabBarAlignment.bottom
        ? configuration.size!.height - radius * 2
        : radius * 2;

    final Offset circleOffset = offset +
        Offset(
          configuration.size!.width / 2,
          yOffset,
        );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
