import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'spacing.dart';

class SkadiPlatformChecker extends StatelessWidget {
  final Widget androidWidget;
  final Widget? iosWidget;
  final Widget? webWidget;

  ///Provide a widget child depend on the Platform, Currently support [iOS] and [Android]
  const SkadiPlatformChecker({
    Key? key,
    required this.androidWidget,
    this.iosWidget,
    this.webWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPlatformChecker();
  }

  Widget buildPlatformChecker() {
    if ((UniversalPlatform.isIOS || UniversalPlatform.isMacOS) &&
        iosWidget != null) {
      return iosWidget ?? emptySizedBox;
    } else if (UniversalPlatform.isWeb && webWidget != null) {
      return webWidget ?? emptySizedBox;
    }
    return androidWidget;
  }
}
