import 'package:flutter/material.dart';

import 'logger.dart';
import 'skadi_navigator.dart';

class SkadiRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final bool log;
  final bool logHistory;
  final void Function(Route route)? analyticCallBack;
  final void Function(String name, String description)? logger;

  ///Route observer that support logging and analytic callback
  SkadiRouteObserver({
    this.log = false,
    this.logHistory = false,
    this.logger,
    this.analyticCallBack,
  });

  static final List<String> _history = [];

  void _addHistory(Route? route) {
    if (route != null) {
      analyticCallBack?.call(route);
      String? routeName = route.settings.name;
      if (routeName != null) {
        _history.add(routeName);
      }
    }
  }

  void _removeHistory(Route? route) {
    if (route != null) {
      String? routeName = route.settings.name;
      if (routeName != null) {
        ///Reverse history to remove last occurrence
        var reverseList = _history.reversed.toList();
        reverseList.remove(routeName);
        _history.clear();

        ///Reverse back
        _history.addAll(reverseList.reversed);
      }
    }
  }

  ///Check if page history contains a route
  static bool historyContains(String route) {
    return _history.contains(route);
  }

  ///Get a copy list of history
  static List<String> get history => [..._history];

  void _log(String name, String description) {
    if (logger != null) {
      logger!.call(name, description);
      if (logHistory) {
        logger!.call("History", history.join());
      }
    } else {
      infoLog(name, description);
      if (logHistory) {
        infoLog("History", history);
      }
    }
  }

  ///Pop the route until a below route name
  ///Will throw a [SkadiRouteException] is route name isn't found in the history
  static void popUntilRoute(BuildContext context, String route) {
    assert(historyContains(route));
    int routePopToIndex = _history.indexOf(route);
    if (routePopToIndex < 0) {
      throw SkadiRouteException("Route not found");
    }
    int popCount = _history.length - (routePopToIndex + 1);
    Navigator.of(context).popUntil((route) => popCount-- <= 0 || route.isFirst);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _removeHistory(route);
    if (log) {
      _log(
        "Skadi Route Observer: DidRemove",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
      );
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      analyticCallBack?.call(previousRoute);
    }
    _removeHistory(route);
    if (log) {
      _log(
        "Skadi Route Observer: DidPop",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
      );
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _addHistory(newRoute);
    _removeHistory(oldRoute);
    if (log) {
      _log(
        "Skadi Route Observer: DidReplace",
        "New Route: ${newRoute?.settings.name}, Old Route: ${oldRoute?.settings.name}",
      );
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _addHistory(route);
    if (log) {
      _log(
        "Skadi Route Observer: DidPush",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
      );
    }
  }
}
