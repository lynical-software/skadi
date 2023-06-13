extension SkadiNumberExtension on num {
  ///Return number as empty string if number is zero
  ///Useful for assign number into TextField
  String get emptyIfZero {
    if (this <= 0) return "";
    return "$this";
  }
}
