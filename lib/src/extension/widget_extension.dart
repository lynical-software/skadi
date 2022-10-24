import 'package:flutter/material.dart';

import '../utilities/skadi_utils.dart';

extension SkadiWidgetExtension on Widget {
  Widget padding([EdgeInsets padding = const EdgeInsets.all(8)]) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  ///add padding all to a widget
  Widget paddingValue({
    double? all,
    double? vertical,
    double? horizontal,
  }) {
    if (all != null && (vertical != null || horizontal != null)) {
      throw FlutterError(
        "paddingValue Error: Can't provide both all and horizontal or vertical at the same time",
      );
    }
    EdgeInsets padding;
    if (horizontal != null || vertical != null) {
      padding = EdgeInsets.symmetric(
        vertical: vertical ?? 0.0,
        horizontal: horizontal ?? 0.0,
      );
    } else {
      padding = EdgeInsets.all(all ?? 0.0);
    }

    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget margin([EdgeInsets margin = const EdgeInsets.all(8)]) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  Widget marginValue({
    double? all,
    double? vertical,
    double? horizontal,
  }) {
    if (all != null && (vertical != null || horizontal != null)) {
      throw FlutterError(
        "marginValue Error: Can't provide both all and horizontal or vertical at the same time",
      );
    }
    EdgeInsets margin;
    if (horizontal != null || vertical != null) {
      margin = EdgeInsets.symmetric(
        vertical: vertical ?? 0.0,
        horizontal: horizontal ?? 0.0,
      );
    } else {
      margin = EdgeInsets.all(all ?? 0.0);
    }

    return Container(
      margin: margin,
      child: this,
    );
  }

  ///Rotate a widget in Degree
  Widget rotate([double degree = 0]) {
    return Transform.rotate(
      angle: SkadiUtils.degreeToRadian(degree),
      child: this,
    );
  }

  Widget opacity([double opacity = 1]) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget get expanded => Expanded(child: this);

  Widget get flexible => Flexible(child: this);

  Widget get ovalClip => ClipOval(child: this);
}
