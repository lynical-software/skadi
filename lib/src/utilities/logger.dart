import 'package:flutter/foundation.dart';
import 'package:skadi/skadi.dart';

class SkadiLogSetting {
  final bool http;
  final bool info;
  final bool debug;
  final bool error;

  ///Setting for logger while in release mode
  ///All log are display by default in debug mode
  const SkadiLogSetting({
    this.debug = false,
    this.http = false,
    this.info = true,
    this.error = true,
  });
}

void debugLog([dynamic log, dynamic additional = "", bool? logInReleaseMode]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || (logInReleaseMode ?? setting.debug)) {
    debugPrint("Skadi Debug Log: $log $additional");
  }
}

void httpLog([dynamic log, dynamic additional = "", bool? logInReleaseMode]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || (logInReleaseMode ?? setting.http)) {
    debugPrint("Skadi Http Log: $log $additional");
  }
}

void infoLog([dynamic log, dynamic additional = ""]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || setting.info) {
    debugPrint("Skadi Info Log: $log $additional");
  }
}

void errorLog([dynamic log, dynamic additional = ""]) {
  var setting = SkadiProvider.loggerSetting;
  if (kDebugMode || setting.error) {
    debugPrint("Skadi Error Log: $log $additional");
  }
}
