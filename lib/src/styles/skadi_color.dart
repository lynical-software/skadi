import 'package:flutter/material.dart';

class SkadiColor {
  ///Get color from String hex code
  ///use defaultColor if there's an error
  static Color fromHexString(String code, {Color defaultColor = Colors.white}) {
    try {
      String hexAlphaPrefix = '0xFF';
      String colorCode;

      if (code.contains(hexAlphaPrefix)) {
        colorCode = code;
      } else {
        colorCode = '0xFF${code.replaceAll("#", "")}';
      }
      return Color(int.parse(colorCode));
    } catch (e) {
      debugPrint("SkadiColor: => Invalid color format");
      return defaultColor;
    }
  }

  ///Get Color from RGB with optional opacity
  static Color fromRGB(int r, int g, int b, [double opacity = 1]) {
    return Color.fromRGBO(r, g, b, opacity);
  }

  ///Convert your color to MaterialColor
  static MaterialColor toMaterial(Color color) {
    final r = color.red;
    final g = color.green;
    final b = color.blue;

    return MaterialColor(
      color.value,
      <int, Color>{
        50: Color.fromRGBO(r, g, b, .1),
        100: Color.fromRGBO(r, g, b, .2),
        200: Color.fromRGBO(r, g, b, .3),
        300: Color.fromRGBO(r, g, b, .4),
        400: Color.fromRGBO(r, g, b, .5),
        500: Color.fromRGBO(r, g, b, .6),
        600: Color.fromRGBO(r, g, b, .7),
        700: Color.fromRGBO(r, g, b, .8),
        800: Color.fromRGBO(r, g, b, .9),
        900: Color.fromRGBO(r, g, b, 1),
      },
    );
  }
}
