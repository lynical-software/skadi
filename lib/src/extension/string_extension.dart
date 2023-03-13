extension SkadiStringExtension on String {
  String get capitalize {
    return this[0].toUpperCase() + substring(1, length);
  }

  bool get isNetworkUrl => startsWith("http") || startsWith("www");

  String get fileExtension {
    return split(".").last;
  }

  num? get toNum {
    return num.tryParse(this);
  }

  String emptyReplace(String replacement) {
    return isEmpty ? replacement : this;
  }
}

extension SkadiNullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
