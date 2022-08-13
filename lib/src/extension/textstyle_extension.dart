import 'package:flutter/material.dart';

extension LynicalTextStyleExtension on TextStyle {
  //method
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get red => copyWith(color: Colors.red);

  TextStyle get green => copyWith(color: Colors.green);

  TextStyle get grey => copyWith(color: Colors.grey);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setSize(double size) {
    return copyWith(fontSize: size);
  }

  TextStyle get responsiveFontSize => copyWith(fontSize: _responsiveFontSize(fontSize ?? 14));
}

double _responsiveFontSize(double size) {
  return size;
  // return LynicalResponsive.value(size, size + 4, size + 6, size - 2);
}
