import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SkadiTimeOfDayExtension on TimeOfDay {
  bool isAfter(TimeOfDay tod) {
    if (hour > tod.hour) return true;
    if (hour == tod.hour) {
      return minute > tod.minute;
    }
    return false;
  }
}

TimeOfDay todFromString(String data) {
  var split = data.split(":");
  int h = int.parse(split.first);
  int m = int.parse(split.last);
  return TimeOfDay(hour: h, minute: m);
}

String todToString(TimeOfDay data) {
  return "${data.hour}:${data.minute}";
}

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
