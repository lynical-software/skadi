import 'package:flutter/material.dart';

import 'logger.dart';

class SkadiRouteException implements Exception {
  final String message;
  SkadiRouteException(this.message);

  @override
  String toString() => message;
}

class SkadiNavigator {
  ///Less boilerplate MaterialPageRoute Navigatoe
  SkadiNavigator._();

  ///short handed push navigator
  ///[routeName] parameter can be use instead of [settings] if you only need to provider routeName
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    String? routeName,
  }) async {
    if (routeName == null && settings == null) {
      routeName = page.runtimeType.toString();
    }
    return await Navigator.of(context).push<T>(
      MaterialPageRoute(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
        settings: routeName != null ? RouteSettings(name: routeName) : settings,
      ),
    );
  }

  ///short handed push replacement navigator
  static Future pushReplacement(
    BuildContext context,
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    String? routeName,
  }) async {
    if (routeName == null && settings == null) {
      routeName = page.runtimeType.toString();
    }
    return await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
        settings: routeName != null ? RouteSettings(name: routeName) : settings,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  ///short handed push and remove navigator
  static Future pushAndRemove(
    BuildContext context,
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    String? routeName,
    bool Function(Route)? condition,
  }) async {
    if (routeName == null && settings == null) {
      routeName = page.runtimeType.toString();
    }
    return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
        settings: routeName != null ? RouteSettings(name: routeName) : settings,
      ),
      condition ?? (route) => false,
    );
  }

  static void popAll(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static void popTime(BuildContext context, int count) {
    int total = 0;
    Navigator.of(context).popUntil((_) => total++ >= count);
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static String? currentRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }
}

class SkadiRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final bool log;

  SkadiRouteObserver({
    this.log = false,
  });
  static final List<String> _history = [];

  void _addHistory(Route? route) {
    if (route != null) {
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
        ///Reverse history to remove last occurence
        var reverseList = _history.reversed.toList();
        reverseList.remove(routeName);
        _history.clear();

        ///Reverse back
        _history.addAll(reverseList.reversed);
      }
    }
  }

  static bool historyContains(String route) {
    return _history.contains(route);
  }

  static void showRoutes() {
    infoLog(
      "Skadi Observer routes history:",
      _history,
      true,
    );
  }

  static void popUntilRoute(BuildContext context, String route) {
    assert(historyContains(route));
    int routePopToIndex = _history.indexOf(route);
    if (routePopToIndex < 0) {
      throw SkadiRouteException("Route not found");
    }
    int popCount = _history.length - (routePopToIndex + 1);
    Navigator.of(context).popUntil((route) => popCount-- <= 0);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _removeHistory(route);
    if (log) {
      infoLog(
        "Skadi Route Observer: DidRemove",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
        true,
      );
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _removeHistory(route);
    if (log) {
      infoLog(
        "Skadi Route Observer: DidPop",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
        true,
      );
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _addHistory(newRoute);
    _removeHistory(oldRoute);
    if (log) {
      infoLog(
        "Skadi Route Observer: DidReplace",
        "New Route: ${newRoute?.settings.name}, Old Route: ${oldRoute?.settings.name}",
        true,
      );
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _addHistory(route);
    if (log) {
      infoLog(
        "Skadi Route Observer: DidPush",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
        true,
      );
    }
    super.didPush(route, previousRoute);
  }
}
