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

  Widget get center => Center(child: this);

  Widget get flexible => Flexible(child: this);

  Widget get ovalClip => ClipOval(child: this);

  SliverToBoxAdapter get sliverToBox => SliverToBoxAdapter(child: this);
}

extension SkadiWidgetListExtension on List<Widget> {
  ///Wrap list of widget in a Row and Expanded each widget
  Widget wrapRowExpended({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        for (var widget in this) Expanded(child: widget),
      ],
    );
  }

  ///Wrap list of widget in a Row
  Widget wrapRow({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: this,
    );
  }

  ///Wrap list of widget in a Column and Expanded each widget
  Widget wrapColumnExpanded({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        for (var widget in this) Expanded(child: widget),
      ],
    );
  }

  ///Wrap list of widget in a Column
  Widget wrapColumn({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: this,
    );
  }
}
