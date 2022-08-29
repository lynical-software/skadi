import 'package:flutter/material.dart';

import '../provider/skadi_provider.dart';

class SkadiFutureHandler<T> extends StatefulWidget {
  ///Future to check on
  final Future<T>? future;
  final Future<T> Function()? futureFunction;

  ///A callback when Future's snapshot hasData
  final Widget Function(T) ready;
  final Widget? loading;
  final T? initialData;

  ///On snapshot error callback
  final Widget Function(dynamic)? error;

  ///Create a FutureBuilder with less boilerplate code
  const SkadiFutureHandler({
    Key? key,
    required this.future,
    required this.ready,
    this.error,
    this.futureFunction,
    this.loading,
    this.initialData,
  }) : super(key: key);

  const SkadiFutureHandler.function({
    Key? key,
    required this.ready,
    required this.futureFunction,
    this.future,
    this.error,
    this.loading,
    this.initialData,
  }) : super(key: key);

  @override
  _SkadiFutureHandlerState<T> createState() => _SkadiFutureHandlerState<T>();
}

class _SkadiFutureHandlerState<T> extends State<SkadiFutureHandler<T>> {
  Future<T>? future;

  @override
  void initState() {
    future = widget.future ?? widget.futureFunction?.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SkadiProvider? skadiProvider = SkadiProvider.of(context);
    //
    return FutureBuilder<T>(
      future: future,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget.ready(snapshot.data as T);
        } else if (snapshot.hasError) {
          if (widget.error != null) {
            return widget.error!(snapshot.error);
          }
          return skadiProvider?.errorWidget?.call(snapshot.error, context) ??
              Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              );
        } else {
          if (widget.loading != null) {
            return widget.loading!;
          }
          return skadiProvider?.loadingWidget ?? const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
