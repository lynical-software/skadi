import '../extension/string_extension.dart';

class SkadiFormValidator {
  static final _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static String? validateField(String? value, {String? field, int? length}) {
    if (value.isNullOrEmpty) {
      return field != null
          ? "Please input your $field"
          : "Please input required field";
    }
    if (length != null) {
      if (value!.length < length) {
        if (field != null) {
          return "$field must be $length characters long";
        } else {
          return "This field required $length characters long";
        }
      }
    }
    return null;
  }

  static String? isNumber(String? value, {String? field}) {
    if (value.isNullOrEmpty) {
      return field != null
          ? "Please input your $field"
          : "Please input required field";
    }
    num? asNumber = num.tryParse(value!);
    if (asNumber is! num) {
      return field != null
          ? "$field must be a number"
          : "This field must be a number";
    }
    return null;
  }

  static String? validateEmail(String? value, {String field = "email"}) {
    if (value.isNullOrEmpty) {
      return "Please input your $field";
    }
    if (!_emailRegex.hasMatch(value!)) {
      return "Invalid $field";
    }
    return null;
  }
}
