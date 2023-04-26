import 'dart:async';

import 'package:flutter/material.dart';

typedef ErrorWidgetFunction = Widget Function(
    dynamic error, BuildContext context);

typedef FutureOrCallBack = FutureOr<void> Function();

typedef JsonMap = Map<String, dynamic>;
