import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiStreamHandler<T> extends StatefulWidget {
  final Stream<T?> stream;

  ///A callback when Stream's snapshot hasData
  final Widget Function(T) ready;

  ///A widget that showing when stream's has no data
  final Widget? loading;

  ///stream initial data
  final T? initialData;

  ///On snapshot error callback
  final Widget Function(dynamic)? error;

  ///A function call when stream has an error
  final void Function(dynamic)? onError;

  ///create a StreamBuilder with less boilerplate code
  const SkadiStreamHandler({
    Key? key,
    required this.stream,
    required this.ready,
    this.error,
    this.onError,
    this.loading,
    this.initialData,
  }) : super(key: key);

  @override
  _SkadiStreamHandlerState<T> createState() => _SkadiStreamHandlerState<T>();
}

class _SkadiStreamHandlerState<T> extends State<SkadiStreamHandler<T>> {
  @override
  void initState() {
    if (widget.onError != null) {
      widget.stream.asBroadcastStream().listen((data) {}, onError: (err) {
        widget.onError?.call(err);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final skadiProvider = SkadiProvider.of(context);
    //
    return StreamBuilder<T?>(
      stream: widget.stream,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
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
