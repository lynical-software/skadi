import 'package:flutter/material.dart';

///Create an override method that call after build method has been called
mixin AfterBuildMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterBuild(context);
    });
    super.initState();
  }

  ///this method will run after build method has been called
  void afterBuild(BuildContext context);
}
