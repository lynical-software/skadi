extension SkadiNumberExtension on num {
  ///Return number as empty string if number is zero
  ///Useful for assign number into TextField
  String get emptyIfZero {
    if (this <= 0) return "";
    return "$this";
  }

  num? get nullIfZero {
    if (this == 0) return null;
    return this;
  }

  ///Replace number with String replacement if number is [zero]
  String zeroReplacement(String replacement) {
    if (this == 0) return replacement;
    return "$this";
  }

  ///Replace number with replacement if number is [zero]
  num zeroNumberReplacement(num replacement) {
    if (this == 0) return replacement;
    return this;
  }
}

extension SkadiNullableNumberExtension on num? {
  bool get isNotNullOrZero {
    if (this == null) return false;
    if (this == 0 || this == 0.0) return false;
    return true;
  }
}
