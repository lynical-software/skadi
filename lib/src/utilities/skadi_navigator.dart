import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiRouteException implements Exception {
  final String message;
  SkadiRouteException(this.message);

  @override
  String toString() => message;
}

BuildContext get skadiContext {
  return SkadiNavigator.navigatorContext;
}

abstract class SkadiNavigator {
  ///Less boilerplate MaterialPageRoute Navigate
  SkadiNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static BuildContext get navigatorContext {
    var ctx = navigatorKey.currentState?.context;
    if (ctx == null) {
      throw SkadiRouteException(
          "Invalid Navigator key. Navigator probably haven't set in MaterialApp");
    }
    return ctx;
  }

  static keyPush(Widget page) {
    return push(navigatorContext, page);
  }

  static keyPushReplacement(Widget page) {
    return pushReplacement(navigatorContext, page);
  }

  static keyPushRemove(Widget page) {
    return pushAndRemove(navigatorContext, page);
  }

  ///short handed push navigator
  ///[routeName] parameter can be use instead of [settings] if you only need to provider routeName
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    String? routeName,

    ///replace current route if contain in history
    ///Mostly push by deep link
    bool replaceIfExist = false,
  }) async {
    if (routeName == null && settings == null) {
      routeName = page.runtimeType.toString();
    }
    if (routeName != null && replaceIfExist) {
      bool exist = SkadiRouteObserver.historyContains(routeName);
      if (exist) {
        SkadiRouteObserver.popUntilRoute(context, routeName);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
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

    ///replace current route if contain in history
    ///Mostly push by deep link
    bool replaceIfExist = false,
  }) async {
    if (routeName == null && settings == null) {
      routeName = page.runtimeType.toString();
    }

    if (routeName != null && replaceIfExist) {
      bool exist = SkadiRouteObserver.historyContains(routeName);
      if (exist) {
        SkadiRouteObserver.popUntilRoute(context, routeName);
      }
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

  ///Pop everything until first route
  static void popAll(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  ///Pop X amount of time
  static void popTime(BuildContext context, int count) {
    int total = 0;
    Navigator.of(context).popUntil((route) {
      return total++ >= count || route.isFirst;
    });
  }

  ///Just a simple pop
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  ///Return current routeName
  static String? currentRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }
}
