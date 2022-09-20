import 'package:flutter/foundation.dart';
import 'package:skadi/skadi.dart';

class SkadiLogSetting {
  final bool http;
  final bool info;
  final bool error;

  ///Setting for logger while in release mode
  ///All log are display by default in debug mode
  const SkadiLogSetting({
    this.http = false,
    this.info = false,
    this.error = true,
  });
}

void httpLog([dynamic log, dynamic additional = "", bool? logInReleaseMode]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || (logInReleaseMode ?? setting.http)) debugPrint("Http Log: $log $additional");
}

void infoLog([dynamic log, dynamic additional = "", bool? logInReleaseMode]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || (logInReleaseMode ?? setting.http)) debugPrint("Info Log: $log $additional");
}

void errorLog([dynamic log, dynamic additional = ""]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || setting.error) debugPrint("Error Log: $log $additional");
}
