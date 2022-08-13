extension LynicalListExtension<T> on List<T> {
  ///Filter list that return empty if no item found.
  List<T> filter(bool Function(T) test) {
    List<T> filtered = [];
    for (var item in this) {
      bool passed = test(item);
      if (passed) filtered.add(item);
    }
    return filtered;
  }

  ///Find one item in the List by condition..
  ///Return null if no item found
  T? findOne(bool Function(T) test) {
    for (var item in this) {
      bool passed = test(item);
      if (passed) {
        return item;
      }
    }
    return null;
  }
}

extension LynicalMapExtension<T, V> on Map<T, V> {
  void addIfNotNull(T key, V value) {
    if (value != null) putIfAbsent(key, () => value);
  }

  V? getIfExist(T key) {
    if (keys.contains(key)) {
      return this[key];
    }
    return null;
  }
}
