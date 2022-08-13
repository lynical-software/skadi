import 'package:flutter/material.dart';

import 'spacing.dart';

///build a widget depend on provided [condition]
class ConditionalWidget extends StatelessWidget {
  ///If a [condition] is true, show [onTrue] widget lese show [OnFalse] widget
  final bool condition;

  ///A function that return a widget if [condition] is true
  final Widget Function() onTrue;

  ///A function that return a widget if [condition] is false
  final Widget Function()? onFalse;

  ///margin of the widget
  final EdgeInsets? margin;

  ///padding of the widget
  final EdgeInsets? padding;

  ///build a widget depend on provided [condition]
  const ConditionalWidget({
    Key? key,
    required this.condition,
    required this.onTrue,
    this.onFalse,
    this.margin,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: condition ? onTrue() : onFalse?.call() ?? emptySizedBox,
    );
  }
}
