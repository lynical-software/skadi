import 'package:flutter/material.dart';

enum SkadiResponsiveRule {
  multiply,
  add,
}

enum SkadiResponsiveBreakpointName {
  mobileSmall,
  mobile,
  tablet,
  desktop,
}

class SkadiResponsiveBreakpoint {
  final double mobileSmall;
  final double mobile;
  final double tablet;
  final double desktop;

  SkadiResponsiveBreakpoint({
    required this.mobileSmall,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  SkadiResponsiveBreakpoint.defaultValue()
      : mobileSmall = 320,
        mobile = 480,
        tablet = 768,
        desktop = 1024;
}

class SkadiResponsive {
  static Size? _size;
  static BuildContext? context;

  static SkadiResponsiveBreakpoint _breakPoint = SkadiResponsiveBreakpoint.defaultValue();

  static double get screenWidth => _size?.width ?? _breakPoint.mobile;

  @protected
  static void _init(BuildContext ctx) {
    context = ctx;
    _size = MediaQuery.of(ctx).size;
  }

  @protected
  static void changeBreakpoint(SkadiResponsiveBreakpoint breakPoint) {
    _breakPoint = breakPoint;
  }

  static SkadiResponsiveBreakpointName _getBreakpointName([BuildContext? context]) {
    double screenWidth = 0.0;
    if (context != null) {
      screenWidth = MediaQuery.of(context).size.width;
    } else {
      screenWidth = screenWidth;
    }
    if (screenWidth >= _breakPoint.desktop) {
      return SkadiResponsiveBreakpointName.desktop;
    } else if (screenWidth >= _breakPoint.tablet) {
      return SkadiResponsiveBreakpointName.tablet;
    } else if (screenWidth <= _breakPoint.mobileSmall) {
      return SkadiResponsiveBreakpointName.mobileSmall;
    }
    return SkadiResponsiveBreakpointName.mobile;
  }

  static bool get isDesktop => screenWidth >= _breakPoint.desktop;
  static bool get isTablet => !isDesktop && screenWidth >= _breakPoint.tablet;
  static bool get isMobile => !isMobileSmall && screenWidth < _breakPoint.tablet;
  static bool get isMobileSmall => screenWidth <= _breakPoint.mobile;

  ///Build a widget base on device screen size
  ///[desktop] builder is nullable and will use [tablet]'s value if null
  ///[mobileSmall] builder is nullable and will use [mobile]'s value if null
  ///React immediately to MediaQuery change if [context] is provided
  static Widget builder({
    required Widget Function() mobile,
    required Widget Function() tablet,
    Widget Function()? desktop,
    Widget Function()? mobileSmall,
    BuildContext? context,
  }) {
    SkadiResponsiveBreakpointName breakpointName = _getBreakpointName(context);
    Widget mobileWidget = mobile();
    switch (breakpointName) {
      case SkadiResponsiveBreakpointName.mobileSmall:
        return mobileSmall?.call() ?? mobileWidget;
      case SkadiResponsiveBreakpointName.mobile:
        return mobile();
      case SkadiResponsiveBreakpointName.tablet:
        return tablet();
      case SkadiResponsiveBreakpointName.desktop:
        return desktop?.call() ?? tablet();
    }
  }

  ///Define a value depend on Screen width
  ///Will use [mobile] value if other value is null
  ///Auto calculate for desktop if tablet isn't null
  ///React immediately to MediaQuery change if [context] is provided
  static double value(
    double mobile, [
    double? tablet,
    double? desktop,
    double? mobileSmall,
    BuildContext? context,
  ]) {
    double? value;
    SkadiResponsiveBreakpointName breakpointName = _getBreakpointName(context);
    switch (breakpointName) {
      case SkadiResponsiveBreakpointName.mobileSmall:
        value = mobileSmall;
        break;
      case SkadiResponsiveBreakpointName.mobile:
        value = mobile;
        break;
      case SkadiResponsiveBreakpointName.tablet:
        value = tablet;
        break;
      case SkadiResponsiveBreakpointName.desktop:

        ///Calculate the value for desktop if it's null and tablet isn't null
        double? defaultForDesktop;
        if (desktop == null && tablet != null) {
          defaultForDesktop = tablet + (tablet - mobile);
        }
        value = desktop ?? defaultForDesktop;
        break;
    }
    return value ?? mobile;
  }

  ///Define a responsive value base on defined rule
  ///Best use case for spacing and container
  ///React immediately to MediaQuery change if [context] is provided
  static double auto(
    double mobile, [
    SkadiResponsiveRule rule = SkadiResponsiveRule.add,
    BuildContext? context,
  ]) {
    double value = mobile;
    SkadiResponsiveBreakpointName breakpointName = _getBreakpointName(context);
    bool isMultiply = rule == SkadiResponsiveRule.multiply;
    switch (breakpointName) {
      case SkadiResponsiveBreakpointName.mobileSmall:
        value = isMultiply ? value - (value * 0.25) : value - 4;
        break;
      case SkadiResponsiveBreakpointName.mobile:
        value = mobile;
        break;
      case SkadiResponsiveBreakpointName.tablet:
        value = isMultiply ? value * 2 : value + 8;
        break;
      case SkadiResponsiveBreakpointName.desktop:
        value = isMultiply ? value * 3 : value + 16;
        break;
    }
    return value;
  }
}

class SkadiResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  final SkadiResponsiveBreakpoint? breakPoint;

  ///Add this widget above your app before using SkadiResponsive
  const SkadiResponsiveBuilder({
    Key? key,
    required this.builder,
    this.breakPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SkadiResponsive._init(context);
    if (breakPoint != null) {
      SkadiResponsive.changeBreakpoint(breakPoint!);
    }
    return builder(context);
  }
}
