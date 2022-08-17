import 'package:flutter/material.dart';

import 'logger.dart';

class SkadiNavigator {
  ///Less boilerplate MaterialPageRoute Navigatoe
  SkadiNavigator._();

  ///short handed push navigator
  ///[routeName] parameter can be use instead of [settings] if you only need to provider routeName
  static Future push<T>(
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
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
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

  void _addHistory(String? route) {
    if (route != null) {
      _history.add(route);
    }
  }

  void _removeHistory(String? route) {
    if (route != null) {
      _history.remove(route);
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
    int popCount = _history.length - (routePopToIndex + 1);
    Navigator.of(context).popUntil((route) => popCount-- <= 0);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (log) {
      infoLog(
        "Skadi Route Observer: DidRemove",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
        true,
      );
    }
    _removeHistory(route.settings.name);
    super.didRemove(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (log) {
      infoLog(
        "Skadi Route Observer: DidPop",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
        true,
      );
    }
    _removeHistory(route.settings.name);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (log) {
      infoLog(
        "Skadi Route Observer: DidReplace",
        "New Route: ${newRoute?.settings.name}, Old Route: ${oldRoute?.settings.name}",
        true,
      );
    }
    _addHistory(newRoute?.settings.name);
    _removeHistory(oldRoute?.settings.name);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (log) {
      infoLog(
        "Skadi Route Observer: DidPush",
        "Route: ${route.settings.name}, Previous Route: ${previousRoute?.settings.name}",
        true,
      );
    }
    _addHistory(route.settings.name);
    super.didPush(route, previousRoute);
  }
}
