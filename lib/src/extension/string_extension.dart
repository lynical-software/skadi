extension SkadiStringExtension on String {
  String get capitalize {
    return this[0].toUpperCase() + substring(1, length);
  }

  String get fileExtension {
    return split(".").last;
  }

  num? get toNum {
    return num.tryParse(this);
  }
}

extension SkadiNullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
