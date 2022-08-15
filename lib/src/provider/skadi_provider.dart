import 'package:flutter/material.dart';

import '../utilities/types.dart';

class SkadiProvider extends InheritedWidget {
  const SkadiProvider({
    Key? key,
    required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
    this.ellipsisText = "",
  }) : super(child: child, key: key);

  ///Loading widget use in [AsyncButton,AsyncIconButton and RaisedButton]
  final Widget? buttonLoadingWidget;

  ///Loading widget use in [FutureHandler,StreamHandler] class
  final Widget? loadingWidget;

  ///Error widget use in [FutureHandler,StreamHandler] class
  final CustomErrorWidget? errorWidget;

  ///A text to replace when EllipsisText's string is null
  final String ellipsisText;

  static SkadiProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkadiProvider>();
  }

  @override
  bool updateShouldNotify(SkadiProvider oldWidget) => true;
}
