import 'package:flutter/material.dart';

import '../utilities/types.dart';

class SkadiProvider extends InheritedWidget {
  ///Provide a setting for Skadi related widgets
  const SkadiProvider({
    Key? key,
    required Widget child,
    this.loadingWidget,
    this.errorWidget,
    this.buttonLoadingWidget,
    this.noDataWidget,
    this.ellipsisText = "",
  }) : super(child: child, key: key);

  ///Loading widget use in [SkadiAsyncButton,SkadiAsyncIconButton and SkadiLoadingButton]
  final Widget? buttonLoadingWidget;

  ///Loading widget use in [SkadiFutureHandler,SkadiStreamHandler] class
  final Widget? loadingWidget;

  ///A widget use in [PaginatedListView] when there is no data
  final Widget? noDataWidget;

  ///Error widget use in [SkadiFutureHandler,SkadiStreamHandler] class
  final CustomErrorWidget? errorWidget;

  ///A text to replace when EllipsisText's string is null
  final String ellipsisText;

  static SkadiProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SkadiProvider>();
  }

  @override
  bool updateShouldNotify(SkadiProvider oldWidget) => true;
}
