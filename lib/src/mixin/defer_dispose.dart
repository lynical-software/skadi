import 'package:flutter/material.dart';

///CREDIT: Thanks to https://www.reddit.com/user/jmatth for this
/// You can found the original comment at:
/// https://www.reddit.com/r/FlutterDev/comments/wwgg1p/comment/ilmcd4e/?utm_source=share&utm_medium=web2x&context=3

/// A mixin to register dispose methods to be automatically called during
/// [State.dispose].
///
/// Mixin to [State] to provide methods for registering [ChangeNotifier.dispose]
/// methods or arbitrary functions to be called during [State.dispose].
mixin DeferDispose<T extends StatefulWidget> on State<T> {
  final List<void Function()> _deferred = [];

  /// Build a [ChangeNotifier] using the provided builder function and defer its
  /// dispose method to be automatically called during [State.dispose].
  ///
  /// Equivalent to:
  /// ```dart
  /// var notifier = builder();
  /// deferDispose(notifier);
  /// ```
  N createDefer<N extends ChangeNotifier>(N Function() builder) {
    final notifier = builder();
    _addDeferDispose(notifier);
    return notifier;
  }

  /// Defer the dispose method on the provided [ChangeNotifier] to be called
  /// during [State.dispose].
  void _addDeferDispose(ChangeNotifier notifier) {
    _deferred.add(notifier.dispose);
  }

  @override
  void dispose() {
    // Run the deferred methods in reverse order just in case there is some
    // poorly implemented dependency between the objects we're disposing.
    for (var i = _deferred.length - 1; i >= 0; i--) {
      _deferred[i].call();
    }
    super.dispose();
  }
}
