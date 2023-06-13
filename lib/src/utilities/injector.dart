import 'package:flutter/material.dart';

typedef DisposeCallback = void Function(List<Object>);

class SkadiInjector extends StatefulWidget {
  final List<Object> dependencies;
  final DisposeCallback? onDispose;
  final Widget child;
  const SkadiInjector({
    super.key,
    required this.dependencies,
    required this.child,
    this.onDispose,
  });

  @override
  State<SkadiInjector> createState() => _SkadiInjectorState();
}

class _SkadiInjectorState extends State<SkadiInjector> {
  //
  void inject(List<Object> objects) {
    for (var obj in objects) {
      SkadiLocator.instance._inject(obj);
    }
  }

  void eject(List<Object> objects) {
    for (var obj in objects) {
      final type = obj.runtimeType;
      SkadiLocator.instance._eject(type);
    }
  }

  @override
  void initState() {
    inject(widget.dependencies);
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call(widget.dependencies);
    eject(widget.dependencies);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SkadiInjector oldWidget) {
    eject(oldWidget.dependencies);
    inject(widget.dependencies);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class SkadiLocator {
  SkadiLocator._();
  static final SkadiLocator instance = SkadiLocator._();

  final Map<Type, Object> _instances = {};

  T? read<T>() {
    return _instances[T] as T?;
  }

  void _inject(Object object) {
    final type = object.runtimeType;
    _instances[type] = object;
    debugPrint("Instance inject: $type");
  }

  void _eject(Type type) {
    final result = _instances.remove(type);
    debugPrint("Instance eject: $result");
  }

  @override
  String toString() {
    String log = "";
    for (var obj in _instances.keys) {
      log += "[$obj]: ${_instances[obj]}\n";
    }
    return log;
  }
}
