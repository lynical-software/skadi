import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

extension SkadiContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get accentColor => Theme.of(this).colorScheme.secondary;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  void hideKeyboard() => FocusScope.of(this).unfocus();

  //SkadiNavigator

  Future<T?> push<T>(Widget page) {
    return SkadiNavigator.push<T>(this, page);
  }

  Future pushReplacement(Widget page) {
    return SkadiNavigator.pushReplacement(this, page);
  }

  Future pushAndRemove(Widget page) {
    return SkadiNavigator.pushAndRemove(this, page);
  }

  void popTime(int count) {
    SkadiNavigator.popTime(this, count);
  }

  void popAll() {
    return SkadiNavigator.popAll(this);
  }

  void pop(dynamic result) {
    return Navigator.of(this).pop(result);
  }
}
