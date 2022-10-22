import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';

class SkadiUtils {
  ///Convert degree to radian because most of Flutter's Widget depends on Radian
  static double degreeToRadian(double degree) {
    return degree * (-pi / 180);
  }

  ///Short for [Future.delayed]
  static Future<T> wait<T>([
    int millisecond = 1500,
    FutureOr<T> Function()? value,
  ]) async {
    await Future.delayed(Duration(milliseconds: millisecond));
    return value == null ? null as T : value.call();
  }

  ///A Function to check network connection
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  ///get bytes from asset that mostly use for google map marker
  static Future<Uint8List> getBytesFromAsset(String path, {int? width}) async {
    ByteData data = await rootBundle.load(path);
    if (width == null) {
      return data.buffer.asUint8List();
    }
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );

    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  ///Get a random image from Picsum with given dimension
  static String picsumImage([int width = 200, int height = 200]) {
    return "https://picsum.photos/$width/$height";
  }

  ///Get a random Image from Unsplash with dimension and category filter
  static String unsplashImage({
    int width = 200,
    int height = 200,
    String category = "photo",
  }) {
    return "https://source.unsplash.com/${width}x$height/?$category";
  }
}
