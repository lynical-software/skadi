import 'package:flutter/cupertino.dart';

///Create a bool type [ValueNotifier] to indicate or define loading state
mixin BoolNotifierMixin<T extends StatefulWidget> on State<T> {
  late ValueNotifier<bool> boolNotifier;

  void toggleValue([bool? value]) {
    boolNotifier.value = value ?? !boolNotifier.value;
  }

  @override
  void initState() {
    boolNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    boolNotifier.dispose();
    super.dispose();
  }
}
