import 'package:flutter/material.dart';

import '../../skadi.dart';

extension SkadiTextStyleExtension on TextStyle {
  // FontWeight
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get boldBlack => copyWith(fontWeight: FontWeight.w900);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  // Color
  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get red => copyWith(color: Colors.red);

  TextStyle get green => copyWith(color: Colors.green);

  TextStyle get grey => copyWith(color: Colors.grey);

  TextStyle get blue => copyWith(color: Colors.blue);

  // Decoration

  ///Create an underline text
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  ///Underline the text with custom style
  TextStyle betterUnderline({
    Color underlineColor = Colors.black,
    double offset = -1,
  }) {
    return copyWith(
      shadows: [
        Shadow(
          color: color ?? underlineColor,
          offset: Offset(0, offset),
        ),
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: color ?? underlineColor,
    );
  }

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get responsiveFontSize =>
      copyWith(fontSize: _responsiveFontSize(fontSize ?? 14));
}

double _responsiveFontSize(double size) {
  return SkadiResponsive.value(size, size + 4, size + 6, size - 2);
}
