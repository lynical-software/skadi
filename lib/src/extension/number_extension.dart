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

  String zeroReplacement(String replacement) {
    if (this == 0) return replacement;
    return "$this";
  }
}
