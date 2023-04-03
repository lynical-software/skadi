import 'dart:math';

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

extension SkadiResponsiveExtension on BuildContext {
  ///
  bool get isDesktop {
    final breakpoint = SkadiResponsive._getBreakpointName(this);
    return breakpoint == SkadiResponsiveBreakpointName.desktop;
  }

  bool get isMobile {
    final breakpoint = SkadiResponsive._getBreakpointName(this);
    return breakpoint == SkadiResponsiveBreakpointName.mobile;
  }

  bool get isTablet {
    final breakpoint = SkadiResponsive._getBreakpointName(this);
    return breakpoint == SkadiResponsiveBreakpointName.tablet;
  }

  bool get isMobileSmall {
    final breakpoint = SkadiResponsive._getBreakpointName(this);
    return breakpoint == SkadiResponsiveBreakpointName.mobileSmall;
  }

  bool get isBigScreenDevice {
    return isTablet || isDesktop;
  }

  ///Return a provided value base of screen width's breakpoint
  double responsive(
    double mobile, [
    double? tablet,
    double? desktop,
    double? mobileSmall,
  ]) {
    return SkadiResponsive.valueOf(
      this,
      mobile,
      tablet,
      desktop,
      mobileSmall,
    );
  }
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
      : mobileSmall = 360,
        mobile = 480,
        tablet = 600,
        desktop = 900;
}

class SkadiResponsive {
  static Size? _size;
  static late BuildContext? _context;

  static SkadiResponsiveBreakpoint _breakPoint = SkadiResponsiveBreakpoint.defaultValue();

  static SkadiResponsiveBreakpoint get breakPoint {
    return _breakPoint;
  }

  ///Get the initial screen width
  static double get screenWidth {
    if (_size == null) {
      throw FlutterError('Please initialize SkadiResponsiveBuilder in MaterialApp builder');
    }
    return _size!.width;
  }

  static bool get isDesktop => screenWidth >= _breakPoint.desktop;
  static bool get isTablet => !isDesktop && screenWidth >= _breakPoint.tablet;
  static bool get isMobile => screenWidth > _breakPoint.mobileSmall && screenWidth < _breakPoint.tablet;
  static bool get isMobileSmall => screenWidth <= _breakPoint.mobileSmall;

  static bool get isBigScreenDevice {
    return screenWidth > _breakPoint.tablet;
  }

  @protected
  static void _init(BuildContext ctx) {
    _context = ctx;
    _size = MediaQuery.of(ctx).size;
  }

  @protected
  static void changeBreakpoint(SkadiResponsiveBreakpoint breakPoint) {
    _breakPoint = breakPoint;
  }

  static SkadiResponsiveBreakpointName _getBreakpointName([BuildContext? context]) {
    double modifiedWidth = 0.0;
    context ??= _context;
    modifiedWidth = context == null ? screenWidth : MediaQuery.of(context).size.width;
    if (modifiedWidth >= _breakPoint.desktop) {
      return SkadiResponsiveBreakpointName.desktop;
    } else if (modifiedWidth >= _breakPoint.tablet) {
      return SkadiResponsiveBreakpointName.tablet;
    } else if (modifiedWidth <= _breakPoint.mobileSmall) {
      return SkadiResponsiveBreakpointName.mobileSmall;
    }
    return SkadiResponsiveBreakpointName.mobile;
  }

  ///Build a widget base on device screen size
  ///[desktop] builder is nullable and will use [tablet]'s value if null
  ///[mobileSmall] builder is nullable and will use [mobile]'s value if null
  ///React immediately to MediaQuery change if [context] is provided
  static Widget builder({
    required Widget Function() mobile,
    required Widget Function() tablet,
    required BuildContext? context,
    Widget Function()? desktop,
    Widget Function()? mobileSmall,
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
          ///Check for edge case where mobile value using screen width which cause it to be bigger than tablet
          if (mobile < tablet) {
            defaultForDesktop = tablet + (tablet - mobile);
          } else {
            defaultForDesktop = tablet;
          }
        }
        value = desktop ?? defaultForDesktop;
        break;
    }
    return value ?? mobile;
  }

  ///React immediately to MediaQuery change if [context] is provided
  ///Define a value depend on Screen width
  ///Will use [mobile] value if other value is null
  ///Auto calculate for desktop if tablet isn't null
  static double valueOf(
    BuildContext context,
    double mobile, [
    double? tablet,
    double? desktop,
    double? mobileSmall,
  ]) {
    return value(
      mobile,
      tablet,
      desktop,
      mobileSmall,
      context,
    );
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
        value = max(0, value);
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

  ///Return a responsive EdgeInsets.all that follow Material Design value
  static EdgeInsets get marginAll {
    return EdgeInsets.all(value(16, 24, 32, 12));
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
