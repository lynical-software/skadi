import 'package:flutter/material.dart';

class SkadiDecoration {
  ///Create a RoundRectangleBorder with given radius
  static RoundedRectangleBorder roundRect([double radius = 8]) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  }

  static RoundedRectangleBorder roundRectTop([double radius = 8]) {
    return RoundedRectangleBorder(borderRadius: radiusTop(radius));
  }

  static RoundedRectangleBorder roundRectBottom([double radius = 8]) {
    return RoundedRectangleBorder(borderRadius: radiusBottom(radius));
  }

  static RoundedRectangleBorder roundRectLeft([double radius = 8]) {
    return RoundedRectangleBorder(borderRadius: radiusLeft(radius));
  }

  static RoundedRectangleBorder roundRectRight([double radius = 8]) {
    return RoundedRectangleBorder(borderRadius: radiusRight(radius));
  }

  ///Create a circular Radius with given radius value
  static BorderRadius radius([double radius = 8]) {
    return BorderRadius.circular(radius);
  }

  static BorderRadius radiusTop([double radius = 8]) {
    return BorderRadius.vertical(top: Radius.circular(radius));
  }

  static BorderRadius radiusBottom([double radius = 8]) {
    return BorderRadius.vertical(bottom: Radius.circular(radius));
  }

  static BorderRadius radiusLeft([double radius = 8]) {
    return BorderRadius.horizontal(left: Radius.circular(radius));
  }

  static BorderRadius radiusRight([double radius = 8]) {
    return BorderRadius.horizontal(right: Radius.circular(radius));
  }
}
