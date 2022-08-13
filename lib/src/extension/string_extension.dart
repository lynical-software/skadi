extension LynicalStringExtension on String {
  String get capitalize {
    return this[0].toUpperCase() + substring(1, length);
  }

  num? get toNum {
    return num.tryParse(this);
  }
}

extension LynicalNullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
