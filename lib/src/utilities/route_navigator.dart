import 'package:flutter/material.dart';

class SkadiNavigator {
  ///Less boilerplate MaterialPageRoute Navigatoe
  SkadiNavigator._();

  ///short handed push navigator
  ///[name] parameter can be use instead of [settings] if you only need to provider name
  static Future push<T>(
    BuildContext context,
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    String? name,
  }) async {
    return await Navigator.of(context).push<T>(
      MaterialPageRoute(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
        settings: name != null ? RouteSettings(name: name) : settings,
      ),
    );
  }

  ///short handed push replacement navigator
  static Future pushReplacement(
    BuildContext context,
    Widget page, {
    bool fullscreenDialog = false,
    RouteSettings? settings,
    String? name,
  }) async {
    return await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
        settings: name != null ? RouteSettings(name: name) : settings,
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
    String? name,
    bool Function(Route)? condition,
  }) async {
    return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
        settings: name != null ? RouteSettings(name: name) : settings,
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
}
