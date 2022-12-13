import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensionX on DateTime {
  String formatDate({String format = "dd MMM yyyy", Locale? locale}) {
    String? localeCode;
    if (locale != null) {
      localeCode = locale.languageCode;
    }
    var formatter = DateFormat(format, localeCode);
    return formatter.format(this);
  }

  bool isTheSameDay(DateTime? dateTime) {
    if (dateTime == null) return false;
    if (dateTime.day == day &&
        dateTime.month == month &&
        dateTime.year == year) {
      return true;
    }
    return false;
  }

  bool isTheSameMonth(DateTime dateTime) {
    return dateTime.month == month && dateTime.year == year;
  }

  bool isTheSameYear(DateTime dateTime) {
    return dateTime.year == year;
  }

  String formatToLocalDate({String format = "dd MMM yyyy", Locale? locale}) {
    String? localeCode;
    if (locale != null) {
      localeCode = locale.languageCode;
    }
    var formatter = DateFormat(format, localeCode);
    final date = toLocal();
    return formatter.format(date);
  }
}
