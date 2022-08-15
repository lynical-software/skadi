import 'package:flutter/material.dart';

extension SkadiContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get accentColor => Theme.of(this).colorScheme.secondary;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  void hideKeyboard() => FocusScope.of(this).unfocus();
}
