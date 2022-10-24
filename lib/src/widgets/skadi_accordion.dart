import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

enum IconPosition {
  start,
  end,
}

///Custom accordion that similar to Flutter's [ExpansionTile]
class SkadiAccordion extends StatefulWidget {
  ///Accordion title, usually a Text
  final Widget title;

  ///A trailing icon that rotate on expanded or collapse
  final Widget icon;

  ///A widgets that show after the widget has expended
  final List<Widget> children;

  ///A callback function that call on every toggle
  final ValueChanged<bool> onToggle;

  ///a condition if to expand to Accordion on initial
  final bool value;

  ///Animation curve when you click to expand or collapse the Accordion
  final Curve curve;

  ///Duration of the animation process
  final Duration animationDuration;

  ///Decoration of the title
  final BoxDecoration? titleDecoration;

  ///Background color of the wrapping children widgets
  final Color? childrenBackgroundColor;

  ///Padding of the title, default value is [EdgeInsets.all(16)]
  final EdgeInsets? titlePadding;

  ///Margin of this widget
  final EdgeInsets margin;

  ///Padding of the children widgets
  final EdgeInsets childrenPadding;

  ///Check if to show the trailing icon
  final bool showIcon;

  ///Check if to run the toggle animation on initial
  final bool animatedOnStart;

  ///Position of the trailing icon
  final IconPosition iconPosition;

  ///Custom accordion that similar to Flutter's [ExpansionTile]
  const SkadiAccordion({
    Key? key,
    required this.title,
    required this.children,
    required this.onToggle,
    required this.value,
    this.margin = const EdgeInsets.all(0.0),
    this.childrenPadding = const EdgeInsets.all(12.0),
    this.icon = const Icon(Icons.keyboard_arrow_down),
    this.curve = Curves.linear,
    this.animationDuration = const Duration(milliseconds: 200),
    this.titlePadding,
    this.titleDecoration,
    this.showIcon = true,
    this.iconPosition = IconPosition.end,
    this.childrenBackgroundColor,
    this.animatedOnStart = false,
  }) : super(key: key);
  @override
  State<SkadiAccordion> createState() => _SkadiAccordionState();
}

class _SkadiAccordionState extends State<SkadiAccordion>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> size;
  late Animation<double> rotation;

  void onToggleAnimation() {
    if (controller.isAnimating) return;
    if (widget.value) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    if (widget.value) {
      widget.animatedOnStart ? controller.forward() : controller.value = 1.0;
    }
    size = CurvedAnimation(curve: widget.curve, parent: controller);
    rotation = Tween<double>(begin: 0.0, end: 0.5).animate(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(SkadiAccordion oldWidget) {
    if (widget.value != oldWidget.value) {
      onToggleAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = RotationTransition(
      turns: rotation,
      alignment: Alignment.center,
      child: widget.icon,
    );

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            onTap: () => widget.onToggle(!widget.value),
            customBorder: RoundedRectangleBorder(
              borderRadius: widget.titleDecoration?.borderRadius ??
                  SkadiDecoration.radius(0),
            ),
            child: Ink(
              decoration: widget.titleDecoration,
              padding: widget.titlePadding ?? const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: widget.iconPosition == IconPosition.start
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.iconPosition == IconPosition.start &&
                      widget.showIcon) ...[
                    icon,
                    const SpaceX(),
                  ],
                  Flexible(
                    child: DefaultTextStyle.merge(
                      child: widget.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  if (widget.iconPosition == IconPosition.end &&
                      widget.showIcon) ...[icon],
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: size,
            child: Container(
              color: widget.childrenBackgroundColor,
              padding: widget.childrenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
