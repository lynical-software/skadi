import 'package:flutter/material.dart';

class ValueNotifierWrapper<T> extends StatefulWidget {
  final T initialValue;
  final Widget? child;
  final Widget Function(
    ValueNotifier<T> notifier,
    T value,
    Widget? child,
  ) builder;
  const ValueNotifierWrapper({
    Key? key,
    required this.initialValue,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  State<ValueNotifierWrapper<T>> createState() =>
      _ValueNotifierWrapperState<T>();
}

class _ValueNotifierWrapperState<T> extends State<ValueNotifierWrapper<T>> {
  late ValueNotifier<T> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      child: widget.child,
      builder: (context, value, child) {
        return widget.builder(notifier, value, child);
      },
    );
  }
}
